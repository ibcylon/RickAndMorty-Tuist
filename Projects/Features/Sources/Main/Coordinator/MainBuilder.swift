//
//  MainBuilder.swift
//  Feature
//
//  Created by Kanghos on 2023/11/27.
//

import UIKit
import Character
import Episode

public final class MainBuilder: MainBuildable {
  public init() { }

  func build(navigationController: UINavigationController) -> MainCoordinating {
    let tabBar = RMTabBarController()
    let characterHome = CharacterBuilder()
    let episodeHome = EpisodeBuilder()

    let coordinator = MainCoordinator(
      navigationController: navigationController,
      mainViewControllable: tabBar,
      characterHome: characterHome,
      episodeHome: episodeHome
    )

    return coordinator
  }
}
