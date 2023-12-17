//
//  LocationCoordinator.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/12/11.
//

import Foundation

import Domain
import Core

public final class LocationCoordinator: BaseCoordinator, LocationCoordinating, CharacterDetailFlow, EpisodeDetailFlow {
  public weak var delegate: LocationCoordinatorDelegate?

  @Injected public var locationUseCase: FetchLocationUseCaseInterface

  private let detailBuildable: DetailBuildable
  private var detailCoordinator: DetailCoordinating?

  public init(
    rootViewController: ViewControllable,
    detailBuildable: DetailBuildable
  ) {
    self.detailBuildable = detailBuildable
    super.init(rootViewController: rootViewController)
  }

  public override func start() {
    attachDetailCoordinator()
    locationHomeFlow()
  }

  func attachDetailCoordinator() {
    let coordinator = detailBuildable.build(rootViewControllable: self.viewControllable)
    attachChild(coordinator)
    coordinator.delegate = self
    self.detailCoordinator = coordinator
  }

  public func locationHomeFlow() {
    let viewModel = LocationListViewModel(useCase: locationUseCase)
    viewModel.delegate = self

    let viewController = LocationListViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func locationDetailFlow(_ item: RMLocation) {
    self.detailCoordinator?.locationDetailFlow(item)
  }

  public func characterDetailFlow(_ item: RMCharacter) {
    self.detailCoordinator?.characterDetailFlow(item)
  }

  public func episodeDetailFlow(_ item: RMEpisode) {
    self.detailCoordinator?.episodeDetailFlow(item)
  }
}
extension LocationCoordinator: DetailCoordinatorDelegate {
  public func detach(coordinator: Coordinator) {
    detachChild(coordinator)
  }
}

extension LocationCoordinator: LocationSearchDelegate {
  func presentItem(_ item: RMLocation) {
    self.locationDetailFlow(item)
  }
}
//
//extension LocationCoordinator: LocationDetailDelegate {
//  public func locationDetailPop() {
//    self.viewControllable.popViewController(animated: true)
//  }
//
//  public func selectCharacter(_ item: RMCharacter) {
//    RMLogger.dataLogger.info("select \(item.name)")
//  }
//}
