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
import EpisodeInterface

protocol MainViewControllable {
  var uiViewController: UIViewController { get }
  func setViewController(_ viewControllers: [UIViewController])
}

final class MainCoordinator: BaseCoordinator, MainCoordinating {
  
  private let characterHome: CharacterBuildable
  private let episodeHome: EpisodeBuildable

  var mainViewControllable: MainViewControllable?
  var delegate: MainCoordinatingDelegate?
  
  public init(
    navigationController: UINavigationController,
    mainViewControllable: MainViewControllable,
    characterHome: CharacterBuildable,
    episodeHome: EpisodeBuildable
  ) {
    self.mainViewControllable = mainViewControllable
    self.characterHome = characterHome
    self.episodeHome = episodeHome
    super.init(navigationController:  navigationController)
  }

  func attachTab() {
    start()
    guard let viewController = mainViewControllable?.uiViewController else { return }
    self.navigationController.viewControllers = [ viewController ]
  }


  override func start() {
    let characterCoordinator = self.characterHome.build()
    let episodeCoordinator = self.episodeHome.build()

    attachChild(characterCoordinator)
    attachChild(episodeCoordinator)

    characterCoordinator.start()
    episodeCoordinator.start()

    let viewControllers = [
      characterCoordinator.navigationController,
      episodeCoordinator.navigationController,
    ]

    mainViewControllable?.setViewController(viewControllers)
  }
  
}
