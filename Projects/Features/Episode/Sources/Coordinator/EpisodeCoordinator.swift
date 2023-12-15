//
//  EpisodeCoordinator.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit
import Core

import Domain
import RxSwift

public final class EpisodeCoordinator: BaseCoordinator, EpisodeCoordinating, CharacterDetailFlow {

  public var delegate: EpisodeCoordinatorDelegate?

  @Injected public var episodeUseCase: FetchEpisodeUseCaseInterface
  @Injected public var characterUseCase: FetchCharacterUseCaseInterface

  private let detailBuildable: DetailBuildable

  public init(
    rootViewControllable: ViewControllable,
    detailBuildable: DetailBuildable
  ) {
    self.detailBuildable = detailBuildable
    super.init(rootViewController: rootViewControllable)
  }

  public override func start() {
    episodeHomeFlow()
  }

  public func episodeHomeFlow() {
    let viewModel = EpisodeListViewModel(useCase: episodeUseCase)

    viewModel.delegate = self
    let viewController = EpisodeListViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func episodeDetailFlow(_ item: RMEpisode) {

    let viewModel = EpisodeDetailViewModel(
      episodeUseCase: episodeUseCase,
      characterUseCase: characterUseCase,
      item: item
    )
    viewModel.delegate = self

    let viewController = EpisodeDetailViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func characterDetailFlow(_ item: RMCharacter) {
    let coordinator = detailBuildable.build(rootViewControllable: self.viewControllable)
    attachChild(coordinator)
    coordinator.delegate = self
    coordinator.characterDetailFlow(item)
  }
}

extension EpisodeCoordinator: EpisodeSearchDelegate {
  func presentItem(_ item: RMEpisode) {
    self.episodeDetailFlow(item)
  }
}
//
extension EpisodeCoordinator: EpisodeDetailDelegate {
  public func selectCharacter(_ item: CharacterInterface.RMCharacter) {
    characterDetailFlow(item)
  }

  public func episodeDetailPop() {
    self.viewControllable.popViewController(animated: true)
  }
}

extension EpisodeCoordinator: DetailCoordinatorDelegate {
  public func detach(coordinator: Core.Coordinator) {
    detachChild(coordinator)
  }
}
