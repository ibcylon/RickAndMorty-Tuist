//
//  MainBuilder.swift
//  Feature
//
//  Created by Kanghos on 2023/11/27.
//

import UIKit

import Core
import Character

public final class MainBuilder: MainBuildable {
  public init() { }

  func build(rootViewControllable: Core.ViewControllable) -> MainCoordinating {
    let tabBar = RMTabBarController()

    let characterHome = CharacterBuilder()

    let coordinator = MainCoordinator(
      rootViewControllable: rootViewControllable,
      mainViewControllable: tabBar,
      characterHome: characterHome
    )

    return coordinator
  }


}
