//
//  AppCoordinator.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/27.
//

import UIKit

import Core

import Character
import CharacterInterface

protocol AppCoordinating {
  func mainFlow()
}

final class AppCoordinator: LaunchCoordinator, AppCoordinating {

  private let mainBuildable: CharacterBuildable

  init(
    rootViewControllable: ViewControllable,
    mainBuildable: CharacterBuildable
  ) {
    self.mainBuildable = mainBuildable
    super.init(rootViewController: rootViewControllable)
  }

  public override func start() {
    mainFlow()
  }

  // MARK: - public

  func mainFlow() {
    let nav = NavigationControllable()
    replaceWindowRootViewController(rootViewController: nav)
    let mainCoordinator = mainBuildable.build(rootViewControllable: nav)

    attachChild(mainCoordinator)
    mainCoordinator.delegate = self

    mainCoordinator.start()
  }
}

extension AppCoordinator: CharacterCoordinatorDelegate {
  func detach(_ coordinator: Core.Coordinator) {
    RMLogger.dataLogger.debug("detach signal")
//    detachChild(self)
  }
}
