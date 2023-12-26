//
//  MainCoordinator.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/10/29.
//

import UIKit
import Core
import Domain

protocol MainViewControllable: ViewControllable {
  func setViewController(_ viewControllers: [ViewControllable])
}

final class MainCoordinator: BaseCoordinator, MainCoordinating {
  
  private let characterHome: CharacterBuildable
  private let locationHome: LocationBuildable
  private let episodeHome: EpisodeBuildable

  var mainViewControllable: MainViewControllable
  weak var delegate: MainCoordinatingDelegate?
  
  public init(
    mainViewControllable: MainViewControllable,
    characterHome: CharacterBuildable,
    locationHome: LocationBuildable,
    episodeHome: EpisodeBuildable
  ) {
    self.mainViewControllable = mainViewControllable
    self.characterHome = characterHome
    self.locationHome = locationHome
    self.episodeHome = episodeHome

    super.init(rootViewController: mainViewControllable)
  }

  override func start() {
    attachTab()
  }

  func attachTab() {
    let characterCoordinator = self.characterHome.build(rootViewControllable: NavigationControllable())

    attachChild(characterCoordinator)

    characterCoordinator.viewControllable.uiController.tabBarItem = .makeTabItem(.character)
    characterCoordinator.delegate = self
    characterCoordinator.start()

    let locationCoordinator = self.locationHome.build(rootViewControllable: NavigationControllable())

    attachChild(locationCoordinator)

    locationCoordinator.viewControllable.uiController.tabBarItem = .makeTabItem(.location)
    locationCoordinator.start()

    let episodeCoordinator = self.episodeHome.build(
      rootViewControllable: NavigationControllable()
    )

    attachChild(episodeCoordinator)

    episodeCoordinator.viewControllable.uiController.tabBarItem = .makeTabItem(.episode)
    episodeCoordinator.start()

    let viewControllers = [
      characterCoordinator.viewControllable,
      locationCoordinator.viewControllable,
      episodeCoordinator.viewControllable
    ]

    mainViewControllable.setViewController(viewControllers)
  }

  func detachTab() {
    self.childCoordinators.forEach { coordinator in
      coordinator.viewControllable.setViewControllers([])
      detachChild(coordinator)
    }
    self.delegate?.detachMain(self)
  }
}

extension MainCoordinator: CharacterCoordinatorDelegate {
  func detach(_ coordinator: Coordinator) {
    detachChild(coordinator)

    detachTab()
  }
}
