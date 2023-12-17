//
//  EpisodeCoordinator.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit
import Core

import Domain

public final class EpisodeCoordinator: BaseCoordinator, EpisodeCoordinating, CharacterDetailFlow, LocationDetailFlow {

  public var delegate: EpisodeCoordinatorDelegate?

  @Injected public var episodeUseCase: FetchEpisodeUseCaseInterface

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
    episodeHomeFlow()
  }
  func attachDetailCoordinator() {
    let coordinator = detailBuildable.build(rootViewControllable: self.viewControllable)
    attachChild(coordinator)
    coordinator.delegate = self
    self.detailCoordinator = coordinator
  }

  public func episodeHomeFlow() {
    let viewModel = EpisodeListViewModel(useCase: episodeUseCase)

    viewModel.delegate = self
    let viewController = EpisodeListViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func episodeDetailFlow(_ item: RMEpisode) {
    self.detailCoordinator?.episodeDetailFlow(item)
  }

  public func characterDetailFlow(_ item: RMCharacter) {
    self.detailCoordinator?.characterDetailFlow(item)
  }
  public func locationDetailFlow(_ item: RMLocation) {
    self.detailCoordinator?.locationDetailFlow(item)
  }
}

extension EpisodeCoordinator: EpisodeSearchDelegate {
  func presentItem(_ item: RMEpisode) {
    self.episodeDetailFlow(item)
  }
}

extension EpisodeCoordinator: DetailCoordinatorDelegate {
  public func detach(coordinator: Core.Coordinator) {
    detachChild(coordinator)
  }
}
