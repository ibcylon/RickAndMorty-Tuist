//
//  CharacterSearchViewModel.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/17.
//

import Foundation

import RxSwift
import RxCocoa

import Core
import CharacterInterface
import Domain

protocol CharacterSearchingDelegate: AnyObject {
  func searchPresentedItem(_ item: RMCharacter)
  func searchingPresentBottomSheet(_ filter: Filter.Item, listener: BottomSheetListener)
  func searchingBackButtonTap()
}

public final class CharacterSearchViewModel: ViewModelType {
  private let useCase: FetchCharacterUseCaseInterface

  weak var delegate: CharacterSearchingDelegate?

  private var disposeBag = DisposeBag()

  init(useCase: FetchCharacterUseCaseInterface) {
    self.useCase = useCase
  }

  deinit { RMLogger.cycle(name: self) }

  public struct Input {
    let searchText: Driver<String>
    let searchTrigger: Driver<Void>
    let onAppear: Driver<Void>
    let itemSelected: Driver<IndexPath>
    let backButtonTap: Driver<Void>
    let filterItemSelected: Driver<IndexPath>
    let paging: Driver<Void>
  }

  public struct Output {
    let characterArray: Driver<[RMCharacter]>
    let hasNextPage: Driver<Bool>
    let filterState: Driver<[Filter.Item]>
    let scrollToTop: Driver<Void>
  }

  private let filterItemsState = BehaviorRelay<Filter.State>(value: .init(list: .makeCharacterFilter()))
}

extension CharacterSearchViewModel {
  public func transform(input: Input) -> Output {
    let store = BehaviorRelay<RMCharacterInfo?>(value: nil)
    let loadedList = BehaviorRelay<[RMCharacter]>(value: [])

    let initialState = input.onAppear

    let stateSignal = Driver.merge(
      initialState,
      filterItemsState.asDriver()
        .map { _ in  }
    )
      .withLatestFrom(filterItemsState.asDriver())

    let filterList = stateSignal
      .map { $0.list
          .filter { $0.name != "name" }
      }
      .map { $0.sorted { $0.priority > $1.priority } }
    let searchText = input.searchText
      .map { $0.isEmpty ? nil : $0 }

    let filter = filterItemsState.asDriver()
      .withLatestFrom(searchText) { state, name in
        return state.mutation(action: .change(.name(name)))
          .list
      }.map {
        return FilterMapper.map($0)
      }.debug("Filter")

    let hasNextPage = store.asDriver()
      .map { $0?.info.next == nil ? false : true }

    let pagingTrigger = input.paging
      .withLatestFrom(hasNextPage)
      .filter { $0 }
      .map { _ in }
      .throttle(.seconds(3), latest: false)

    let searchTrigger = input.searchTrigger
      .map {
        store.accept(nil)
        loadedList.accept([])
      }


    let loadTrigger = Driver
      .merge(searchTrigger, pagingTrigger)
      .withLatestFrom(filter)



    let addedList = loadTrigger
      .withLatestFrom(store.asDriver()) { return ($0, $1) }
      .asObservable()
      .flatMapLatest(weak: self) { owner, store -> Observable<RMCharacterInfo> in
        let (filter, currentStore) = store
        guard let nextPage = currentStore?.info.nextPagenumber else {
          return owner.useCase.fetchCharactersByFilter(filter: filter, page: 1)
        }
        return owner.useCase.fetchCharactersByFilter(filter: filter, page: nextPage)
      }
      .asDriver(onErrorDriveWith: .empty())
      .map {
        store.accept($0)
        var mutable = loadedList.value
        mutable.append(contentsOf: $0.results)
        loadedList.accept(mutable)
        return mutable
      }

    input.itemSelected
      .withLatestFrom(loadedList.asDriver()) { indexPath, array in
        RMLogger.dataLogger.debug("\(indexPath)")
        RMLogger.dataLogger.debug("\(array.count)")
        return array[indexPath.item]
      }
      .drive(with: self, onNext: { owner, item in
        owner.delegate?.searchPresentedItem(item)
      })
      .disposed(by: disposeBag)

    input.backButtonTap
      .drive(with: self) { owner, _ in
        owner.delegate?.searchingBackButtonTap()
      }
      .disposed(by: disposeBag)

    input.filterItemSelected
      .withLatestFrom(filterList) { index, array in
        array[index.item]
      }
      .drive(with: self) { owner, filterItem in
        owner.delegate?.searchingPresentBottomSheet(filterItem, listener: owner)
      }
      .disposed(by: disposeBag)

    return Output(
      characterArray: addedList,
      hasNextPage: hasNextPage,
      filterState: filterList,
      scrollToTop: searchTrigger
    )
  }
}

extension CharacterSearchViewModel: BottomSheetListener {
  public func setFilter(item: Filter.Item) {
    let state = self.filterItemsState.value.mutation(action: .change(item))
    self.filterItemsState.accept(state)
  }
}

struct FilterMapper {
  static func map(_ items: [Filter.Item]) -> RMCharacterFilter {
    let parameterDict = items.toParameter()

    return RMCharacterFilter(
      name: parameterDict["name"]!, species: parameterDict["species"]!,
      type: parameterDict["type"]!, status: parameterDict["status"]!,
      gender: parameterDict["gender"]!
    )
  }
}
