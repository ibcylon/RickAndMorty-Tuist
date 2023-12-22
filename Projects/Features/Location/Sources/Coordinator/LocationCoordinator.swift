//
//  LocationCoordinator.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/12/11.
//

import Foundation

import Domain
import Core

public final class LocationCoordinator: BaseCoordinator, LocationCoordinating {
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

  public func locationHomeFlow() {
    let viewModel = LocationListViewModel(useCase: locationUseCase)
    viewModel.delegate = self

    let viewController = LocationListViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func locationDetailFlow(_ item: RMLocation) {
    attachDetailCoordinator()
    self.detailCoordinator?.locationDetailFlow(item)
  }
}
extension LocationCoordinator: DetailCoordinatorDelegate {
  public func detach(coordinator: Coordinator) {
    detachDetailCoordinator()
  }
}

extension LocationCoordinator: LocationSearchDelegate {
  func presentItem(_ item: RMLocation) {
    self.locationDetailFlow(item)
  }
}
