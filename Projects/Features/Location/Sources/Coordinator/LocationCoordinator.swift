//
//  LocationCoordinator.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/12/11.
//

import Foundation

import LocationInterface
import Core

public protocol LocationCoordinatorDelegate: AnyObject {

}

public final class LocationCoordinator: BaseCoordinator, LocationCoordinating {
  public weak var delegate: LocationCoordinatorDelegate?

  @Injected public var locationUseCase: FetchLocationUseCaseInterface

  public override func start() {
    locationHomeFlow()
  }

  public func locationHomeFlow() {
    let viewModel = LocationListViewModel(useCae: locationUseCase)
    viewModel.delegate = self

    let viewController = LocationListViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func locationDetailFlow(_ item: RMLocation) {
    let viewModel = LocationDetailViewModel(useCase: locationUseCase, item: item)
    viewModel.delegate = self

    let viewController = LocationDetailViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }
}

extension LocationCoordinator: LocationSearchDelegate {
  func presentItem(item: RMLocation) {
    self.locationDetailFlow(item)
  }
}

extension LocationCoordinator: LocationDetailDelegate {
  func pop() {
    self.viewControllable.popViewController(animated: true)
  }
}
