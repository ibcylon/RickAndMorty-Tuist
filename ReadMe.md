# ReadMe.md

### 소개

RickAndMorty API를 이용한 검색 어플리케이션
Tuist - uFeature Architecture 적용해보는 프로젝트

### 데모
![RickAndMorty GIF](https://github.com/ibcylon/RickAndMorty-Tuist/assets/25360781/28804c99-97a1-4b9a-b7f5-1b1c9c0b8e34)
![Simulator Screen Recording - iPhone 15 - 2023-12-27 at 10 27 15](https://github.com/ibcylon/RickAndMorty-Tuist/assets/25360781/d8d04059-bec5-4f58-88d6-6f7e0397acbb)
### 요구사항

- 필터 검색
- Paging
- 다른 피처 화면 사용
- 레지스터와 메인 탭 Flow 분기
## 아키텍처
Clean Architecture Layer인 Data / Domain / Presentation의 구조를 uFeature(마이크로 피처) 아키텍처로 적용하였습니다.

## 개발하면서 고려한 사항

### uFeature Modular
- 코드 접근자 최적화
- 모듈 독립성

[uFeature Tuist Template 레포 주소](https://github.com/ibcylon/Tuist-uFeature-Template)
자세한 내용은 tuist uFeature Template 참조

### Observable을 사용하는 범위

RxSwift를 사용하는 범위를 어디까지해야 하나 고민했다. 타입 변환이 까다로운 만큼 복잡도가 올라갈 수 있었다.

해서 VC / VM / UseCase 통신만 Observable로 처리하고, 화면전환, Event 전달 등의 화면끼리의 통신은 Coordinator에서 delegate만을 사용하였다.

### Coordinator를 사용할 때 Stream 전달

필터 검색 기능을 하면서 필터 선택 BottomSheet 이벤트를 부모 뷰로 연결하는 작업을 고민하게 되었다. 서로가 서로를 모르기 때문에 Coordinator를 거쳐서 통신을 해야했다. Rx, Delegate, Closure 등의 방법이 있었지만, Rx는 위에서 정한 규칙으로 사용하지 않았다. RIBs 강의에서 들은 “자식→ 부모같은 명확한 1:1 상황에서는 delegate를 사용하는게 강제성도 있고, 코드 이해하기 쉽다”는 판단으로 delegate를 사용했다. 

1. Listenr Delegate이 만들고, VM이 들게했다.
2. Coordinator method를 통해 Listenr를 부모에게 전달
3. 부모가 conform

```swift
// BottomSheetProtocol - Domain Module
public protocol BottomSheetListener: AnyObject {
  func setFilter(item: Filter.Item)
}

// BottomSheetViewModel.swift
weak var listener: BottomSheetListener?

// CharacterSearchViewModel.swift - Character Module
protocol CharacterSearchingDelegate: AnyObject {
  func searchingPresentBottomSheet(_ filter: Filter.Item, listener: BottomSheetListener
}

// CharacterSearchViewModel class
weak var delegate: CharacterSearchingDelegate?

extension CharacterSearchViewModel: BottomSheetListener {
  public func setFilter(item: Filter.Item) {
    let state = self.filterItemsState.value.mutation(action: .change(item))
    self.filterItemsState.accept(state)
  }
}

// CharacterCoordinator - Character Module
extension CharacterCoordinator: CharacterSearchingDelegate {

  // 메소드를 통해 리스너 전달
  func searchingPresentBottomSheet(_ filter: Filter.Item, listener: BottomSheetListener) {
    if filter.hasOptions {
      chooseBottomSheet(filter, listener: listener)
    } else {
      typingBottomSheet(filter, listener: listener)
    }
  }

public func chooseBottomSheet(_ filter: Filter.Item, listener: BottomSheetListener) {
    RMLogger.dataLogger.debug("selected Item \(filter.name)")
    guard filter.hasOptions else { return }
    let viewModel = ChooseBottomSheetViewModel(filterType: filter)
    viewModel.listener = listener // 리스너 바인딩
    viewModel.delegate = self
    let viewController = ChooseBottomSheet()
    viewController.viewModel = viewModel

    self.viewControllable.presentBottomSheet(viewController, animated: true)
  }
}
```

### Rx-flatMap weak self 보일러 플레이트

drive()나 bind()같은 경우는 withUnstraind()나 (with: self)같은 슈가 코드가 있었다. 하지만 useCase 호출같은 Stream연결을 위해 flatMap을 자주 사용하는데 여기에서 weak self 코드 / return 처리가 매번하기 번거로웠다.

```swift
//Rx+Util - Core Module
public extension ObservableType {
  func flatMapLatest<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
    return flatMapLatest { [weak obj] value -> Observable<O.Element> in
      try obj.map { try selector($0, value).asObservable() } ?? .empty() }
  }
}
```

### Diffable DataSource Generic

각 피처에서 DataSource를 사용하는 코드가 중복된다고 판단해서 GenericDataSourceViewController를 만들었다. challenge는 cell 바인딩 메소드에 구체적인 Model을 넣어야하는 점이었다.

Generic을 잘 활용한 레퍼런스가 CleanArchitecture의 Cache와 RIBs의 Router가 있어서 참조하였다.

1. AbstractCellType protocol
2. BaseCell class이 AbstractCellType conform
3. ConcreteType Cell이 BaseCell 상속

```swift
// Core - Module
public protocol AbstarctCellType {
  associatedtype I

  func bind(_ item: I)
}

open class BaseDiffableCell<I>: UICollectionViewCell, AbstarctCellType where I: Hashable {
  public typealias Item = I
  open func bind(_ item: Item) { }
}

// LocationListCell - Location Interface Module

final class LocationListCell: BaseDiffableCell<RMLocation>
```

```swift
// BaseDiffableDataSourceViewController - Core Module
open class BaseDiffableDataSourceViewController<CellType, ModelType>: RMBaseViewController where CellType: BaseDiffableCell<ModelType>, ModelType: Hashable

typealias DataSource = UICollectionViewDiffableDataSource<Section, ModelType>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ModelType>

let cellRegistration = UICollectionView.CellRegistration<CellType, ModelType> { cell, indexPath, item in
  cell.bind(item)
}
```

## 트러블 슈팅

### memory leak

Coordinator, VC, VM deinit이 호출되지 않아 디버깅해보았다. 프로파일러에서는 릭이 발생한다고 나오지 않았지만, xcode 창내에서 메모리는 계속 증가하고 있었다.

- filter()에서 self capture: 고차함수 안에서 self를 참조해서 해제가 안되었음.
- delegate strong self capture cycle: coordinator delegate를 weak으로 선언하지 않아 강한 참조되었음

### Feature Detail Page간의 Flow

이 앱에는 캐릭터 / 로케이션 / 에피소드 3개의 피처가 있다. 각 피처 아이템의 디테일 화면에서 다른 피처의 디테일 페이지로 이동하는 Flow가 필요했다. 모듈에서는 다른 모듈의 페이지에 접근할 수도 없고, 페이지는 module interface에 있지 않았다. 따라서, 기존의 리스트 → 디테일 flow를 가진 Coordinator를 고쳤다.

1. 각 피처의 디테일 페이지를 public으로 수정
2. 모든 피처의 Model을 의존하고 있는 Domain 모듈을 만듦
3. Domain 모듈에서 피처 디테일 페이지 flow를 가지고 있는 Detail Coordinator Interface 생성
4. Glue Layer(Feature Layer)에서 Detail Coordinator Impl 생성하여 각 피처로 Injection

### Search - Diffable Datasource snapshot 문제

기존 페이징 리스트화면은 추가된 아이템들만 DataSource에 추가하면 됐지만, 검색화면 같은 경우는 DataSource를 비우고 스크롤도 올려야 했다.

분기를 어떻게 처리할까 했는데 SnapShot을 새로만드는 메소드를 추가하고, 이벤트에 scroll을 최상단으로 올리는 로직을 추가했다.

```swift
func refreshDataSource(_ items: [RMCharacter]) {
  var snapshot = self.dataSource.snapshot()
  snapshot.appendItems(items)
  self.dataSource.apply(snapshot)
}

func bindDataSource(_ items: [RMCharacter]) {
  var snapshot = Snapshot()
  snapshot.appendSections([.main])
  snapshot.appendItems(items, toSection: .main)
  self.dataSource.apply(snapshot)
}
```

- search filter의 generalize

### Demo App에서 SceneDelegate가 안 붙는 문제

AppDelegate는 문제없이 실행되는데 SceneDelegate를 인식 못하였다. 처음엔 경로 문제인지 알고 수정해보고 추가해보고 했으나, tuist generate된 Demo App Target의 info plist에서 아예 누락되어 버린 것을 확인하였다. bundleID, bundleName이 문제여서 수정하여 해결하였다.

### ListPaging

다른 카드 뷰 셀과 다르게 리스트 뷰셀만 페이징이 잘 안 됐다. 로그달고, rx.debug() 달아서 확인해보니 paging signal을 못받고 있었다. 계산식 offset값에 보정을 주어서 해결하였다.

```swift
//ScrollView+Util - Core Module
public extension UIScrollView {
  var needMorePage: Bool {
    let offset = self.contentOffset.y
    let totalContentHeight = self.contentSize.height
    let totalScrollViewFixedHeight = self.frame.size.height

    if offset >= (totalContentHeight - totalScrollViewFixedHeight) - 10 {
      return true
    }
    return false
  }
}
```

### Main과 Register 분기 처리

분기 처리하는 것은 Coordinator를 이용하여 어렵지 않았다. 하지만 네비게이션바의 높이가 서로 다른 문제가 발생하였다. view hierarchy를 살펴보니, Main 분기의 경우 계층이 다음과 같았다. 
LaunchScreen Navigation / TabBar /Feature Navigation
Root가 되는 피처 코디네이터의 경우에는 KeyWindow를 추출해서 rootViewController를 변경하는 방식으로 해결하였다.

```swift
//BaseCoordinator.swift - Core Module
public func replaceWindowRootViewController(rootViewController: ViewControllable) {
    let keyWindow = UIWindow.keyWindow
    keyWindow?.rootViewController = rootViewController.uiController
    keyWindow?.makeKeyAndVisible()
  }

//UIWindow+Util - Core Module
public extension UIWindow {
  static var keyWindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .compactMap { ($0 as? UIWindowScene)?.keyWindow }
      .last
  }
}
```
## 리팩토링 해야할 것

- Compositional CollectionView Layout으로 전환
- Diffable DataSource Model ID 최적화 and Digging

