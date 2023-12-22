//
//  EpisodeCoordinator.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit
import Core

import Domain

public final class EpisodeCoordinator: BaseCoordinator, EpisodeCoordinating {

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
    episodeHomeFlow()
  }

  func attachDetailCoordinator() {
    if self.detailCoordinator != nil {
      return
    }

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

  public func episodeHomeFlow() {
    let viewModel = EpisodeListViewModel(useCase: episodeUseCase)

    viewModel.delegate = self
    let viewController = EpisodeListViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func episodeDetailFlow(_ item: RMEpisode) {
    attachDetailCoordinator()
    self.detailCoordinator?.episodeDetailFlow(item)
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
