
import UIKit
import Core
import Domain

public final class CharacterCoordinator: BaseCoordinator, CharacterCoordinating, EpisodeDetailFlow, LocationDetailFlow, BottomSheetFlow {

  public weak var delegate: CharacterCoordinatorDelegate?

  @Injected public var characterUseCase: FetchCharacterUseCaseInterface

  private let detailBuildable: DetailBuildable
  private var detailCoordinator: DetailCoordinating?

  public init(
    rootViewControllable: ViewControllable,
    detailBuildable: DetailBuildable
  ) {
    self.detailBuildable = detailBuildable
    super.init(rootViewController: rootViewControllable)
  }

  public override func start() {
    attach()
    characterHomeFlow()
  }

  func attach() {
    attachDetailCoordinator()
  }

  func detach() {
    detachDetailCoordinator()
    self.viewControllable.setViewControllers([])
    self.delegate?.detach(self)
  }

  // MARK: Private
  public func characterHomeFlow() {
    let viewModel = CharacterListViewModel(useCase: characterUseCase)

    viewModel.delegate = self
    let viewController = CharacterListViewController(
      viewModel: viewModel
    )

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func attachDetailCoordinator() {
    let coordinator = detailBuildable.build(rootViewControllable: self.viewControllable)
    attachChild(coordinator)
    coordinator.delegate = self
    self.detailCoordinator = coordinator
  }

  func detachDetailCoordinator() {
    guard let coordinator = self.detailCoordinator else {
      return
    }
    coordinator.delegate = nil
    detachChild(coordinator)
    self.detailCoordinator = nil
  }

  public func characterSearchFlow() {
    let viewModel = CharacterSearchViewModel(useCase: characterUseCase)
    viewModel.delegate = self
    let viewController = CharacterSearchViewController(viewModel: viewModel)

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func characterDetailFlow(_ item: RMCharacter) {
    self.detailCoordinator?.characterDetailFlow(item)
  }

  public func episodeDetailFlow(_ item: RMEpisode) {
    self.detailCoordinator?.episodeDetailFlow(item)
  }

  public func locationDetailFlow(_ item: RMLocation) {
    self.detailCoordinator?.locationDetailFlow(item)
  }

  public func chooseBottomSheet(_ filter: Filter.Item, listener: BottomSheetListener) {
    RMLogger.dataLogger.debug("selected Item \(filter.name)")
    guard filter.hasOptions else { return }
    let viewModel = ChooseBottomSheetViewModel(filterType: filter)
    viewModel.listener = listener
    viewModel.delegate = self
    let viewController = ChooseBottomSheet()
    viewController.viewModel = viewModel

    self.viewControllable.presentBottomSheet(viewController, animated: true)
  }

  public func typingBottomSheet(_ filter: Filter.Item, listener: BottomSheetListener) {
    RMLogger.dataLogger.debug("selected Item \(filter.name)")
    guard !filter.hasOptions else { return }
    let viewModel = TypingBottomSheetViewModel(filterType: filter)
    viewModel.listener = listener
    viewModel.delegate = self
    let viewController = TypingBottomSheet()
    viewController.viewModel = viewModel

    self.viewControllable.presentBottomSheet(viewController, animated: true)
  }
}

extension CharacterCoordinator: CharacterSearchDelegate {
  func presentItem(item: RMCharacter) {
    self.characterDetailFlow(item)
  }
  func logout() {
    self.detach()
  }
  func searchButtonTap() {
    self.characterSearchFlow()
  }
}

extension CharacterCoordinator: CharacterSearchingDelegate {
  
  func searchPresentedItem(_ item: RMCharacter) {
    characterDetailFlow(item)
  }
  func searchingPresentBottomSheet(_ filter: Filter.Item, listener: BottomSheetListener) {
    if filter.hasOptions {
      chooseBottomSheet(filter, listener: listener)
    } else {
      typingBottomSheet(filter, listener: listener)
    }
  }
  func searchingBackButtonTap() {
    viewControllable.popViewController(animated: true)
  }
}

extension CharacterCoordinator: DetailCoordinatorDelegate {
  public func detach(coordinator: Coordinator) {
    detachChild(coordinator)
  }
}

extension CharacterCoordinator: BottomSheetViewModelDelegate {
  public func onDismiss() {
    self.viewControllable.uiController.dismiss(animated: true)
  }
}
