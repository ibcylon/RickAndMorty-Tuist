//
//  LocationCoordinator.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/12/11.
//

import Foundation

import LocationInterface
import CharacterInterface
import Core

public final class LocationCoordinator: BaseCoordinator, LocationCoordinating {
  public weak var delegate: LocationCoordinatorDelegate?

  @Injected public var locationUseCase: FetchLocationUseCaseInterface
  @Injected public var characteruseCase:
  FetchCharacterUseCaseInterface

  public override func start() {
    locationHomeFlow()
  }

  public func locationHomeFlow() {
    let viewModel = LocationListViewModel(useCase: locationUseCase)
    viewModel.delegate = self

    let viewController = LocationListViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func locationDetailFlow(_ item: RMLocation) {
    let viewModel = LocationDetailViewModel(
      locationUseCase: locationUseCase,
      characterUseCase: characteruseCase,
      item: item
    )
    viewModel.delegate = self

    let viewController = LocationDetailViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }
}

extension LocationCoordinator: LocationSearchDelegate {
  func presentItem(_ item: RMLocation) {
    self.locationDetailFlow(item)
  }
}

extension LocationCoordinator: LocationDetailDelegate {
  public func locationDetailPop() {
    self.viewControllable.popViewController(animated: true)
  }

  public func selectCharacter(_ item: RMCharacter) {
    RMLogger.dataLogger.info("select \(item.name)")
  }
}
