
import UIKit
import Core
import RxSwift
import EpisodeInterface

public protocol EpisodeCoordinatorDelegate: AnyObject { // 코디네이터 간의 이동 딜리게이터
  func logout()
}

public final class EpisodeCoordinator: BaseCoordinator, EpisodeCoordinating {

  public var delegate: EpisodeCoordinatorDelegate?

  @Injected public var episodeUseCase: FetchEpisodeUseCaseInterface

  public override func start() {
    episodeListFlow()
  }

  // MARK: Private
  private func episodeListFlow() {
    let viewModel = EpisodeListViewModel(useCase: episodeUseCase)

    viewModel.delegate = self

    let viewController = EpisodeListViewController()
    viewController.viewModel = viewModel

    self.navigationController.pushViewController(viewController, animated: true)
  }

  public func episodeDetailFlow(item: RMEpisode) {

    let viewModel = EpisodeDetailViewModel(useCase: episodeUseCase, item: item)
    viewModel.delegate = self

    let viewController = EpisodeDetailViewController()
    viewController.viewModel = viewModel

    self.navigationController.pushViewController(viewController, animated: true)
  }
}

extension EpisodeCoordinator: EpisodeSearchDelegate {
  func presentItem(item: RMEpisode) {
    self.episodeDetailFlow(item: item)
  }
}

extension EpisodeCoordinator: EpisodeDetailDelegate {
  func pop() {
    self.navigationController.popViewController(animated: true)
  }
}
