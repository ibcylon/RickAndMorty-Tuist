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

protocol MainViewControllable {
  var uiViewController: UIViewController { get }
  func setViewController(_ viewControllers: [UIViewController])
}

final class MainCoordinator: BaseCoordinator, MainCoordinating {
  
  private let characterHome: CharacterBuildable

  var mainViewControllable: MainViewControllable?
  var delegate: MainCoordinatingDelegate?
  
  public init(
    navigationController: UINavigationController,
    mainViewControllable: MainViewControllable,
    characterHome: CharacterBuildable
  ) {
    self.mainViewControllable = mainViewControllable
    self.characterHome = characterHome
    super.init(navigationController:  navigationController)
  }

  func attachTab() {
    start()
    guard let viewController = mainViewControllable?.uiViewController else { return }
    self.navigationController.viewControllers = [ viewController ]
  }


  override func start() {
//    let characterCoordinator = self.characterHome.build()
//
//    attachChild(characterCoordinator)
//
//    characterCoordinator.start()
//
//    let viewControllers = [
//      characterCoordinator.navigationController
//    ]
//
//    mainViewControllable?.setViewController(viewControllers)
  }
  
}
