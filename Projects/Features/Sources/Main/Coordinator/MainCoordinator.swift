//
//  MainCoordinator.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/10/29.
//

import UIKit
import Core
import Character
import CharacterInterface

protocol MainViewControllable: ViewControllable {
  func setViewController(_ viewControllers: [ViewControllable])
}

final class MainCoordinator: BaseCoordinator, MainCoordinating {
  
  private let characterHome: CharacterBuildable

  var mainViewControllable: MainViewControllable
  var delegate: MainCoordinatingDelegate?
  
  public init(
    rootViewControllable: ViewControllable,
    mainViewControllable: MainViewControllable,
    characterHome: CharacterBuildable
  ) {

    rootViewControllable.setViewControllers([mainViewControllable])
    
    self.mainViewControllable = mainViewControllable
    self.characterHome = characterHome
    super.init(rootViewController: mainViewControllable)
  }

  override func start() {
    attachTab()
  }

  func attachTab() {
    let characterCoordinator = self.characterHome.build(rootViewControllable: NavigationControllable())

    attachChild(characterCoordinator)
    characterCoordinator.viewControllable.uiController.tabBarItem = .makeTabItem(.character)
    characterCoordinator.start()

    let viewControllers = [
      characterCoordinator.viewControllable
    ]

    mainViewControllable.setViewController(viewControllers)
  }
}
