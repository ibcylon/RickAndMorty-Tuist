
import UIKit
import Core
import RxSwift
import Domain

public final class CharacterCoordinator: BaseCoordinator, CharacterCoordinating, EpisodeDetailFlow, LocationDetailFlow {

  public var delegate: CharacterCoordinatorDelegate?

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
    attachDetailCoordinator()
    characterHomeFlow()
  }

  // MARK: Private
  public func characterHomeFlow() {
    let viewModel = CharacterListViewModel(useCase: characterUseCase)

    viewModel.delegate = self
    let viewController = CharacterListViewController()
    viewController.viewModel = viewModel


    self.viewControllable.pushViewController(viewController, animated: true)
  }

  func attachDetailCoordinator() {
    let coordinator = detailBuildable.build(rootViewControllable: self.viewControllable)
    attachChild(coordinator)
    coordinator.delegate = self
    self.detailCoordinator = coordinator
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
}

extension CharacterCoordinator: CharacterSearchDelegate {
  func presentItem(item: RMCharacter) {
    self.characterDetailFlow(item)
  }
  func logout() {
    self.viewControllable.setViewControllers([])
    self.delegate?.detach(self)
  }
}

extension CharacterCoordinator: CharacterDetailDelegate {
  public func characterDetailPop() {
    self.viewControllable.popViewController(animated: true)
  }
  public func characterDetailSelectEpisode(_ item: RMEpisode) {
    episodeDetailFlow(item)
  }
  public func characterDetailSelectLocation(_ item: RMLocation) {
    locationDetailFlow(item)
  }
}

extension CharacterCoordinator: DetailCoordinatorDelegate {
  public func detach(coordinator: Coordinator) {
    detachChild(coordinator)
  }
}
