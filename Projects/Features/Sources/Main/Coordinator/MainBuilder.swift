//
//  MainBuilder.swift
//  Feature
//
//  Created by Kanghos on 2023/11/27.
//

import UIKit

import Core
import Domain

import Character
import Location
import Episode

public final class MainBuilder: MainBuildable {
  public init() { }

  func build(rootViewControllable: Core.ViewControllable) -> MainCoordinating {
    let tabBar = RMTabBarController()

    let detailBuilder = DetailBuilder()
    
    let characterHome = CharacterBuilder(detailBuildable: detailBuilder)
    let locationHome = LocationBuilder(detailBuildable: detailBuilder)
    let episodeHome = EpisodeBuilder(detailBuildable: detailBuilder)

    rootViewControllable.setViewControllers([tabBar])

    let coordinator = MainCoordinator(
      mainViewControllable: tabBar,
      characterHome: characterHome,
      locationHome: locationHome,
      episodeHome: episodeHome
    )

    return coordinator
  }


}
