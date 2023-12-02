//
//  AppCoordinator.swift
//  App
//
//  Created by Kanghos on 2023/12/01.
//

import UIKit
import Core

protocol AppCoordinating {
  func registerFlow()
  func mainFlow()
}

final class AppCoordinator: LaunchRouter, AppCoordinating {

  private let mainBuildable: MainBuildable
  private let registerBuildable: RegisterBuildable

  init(
    navigationController: UINavigationController,
    mainBuildable: MainBuildable,
    registerBuildable: RegisterBuildable
  ) {
    self.mainBuildable = mainBuildable
    self.registerBuildable = registerBuildable
    super.init(navigationController: navigationController)
  }

  public override func start() {
    mainFlow()
    print("APpCoordin")
  }

  // MARK: - public
  func registerFlow() {
    let registerCoordinator = self.registerBuildable.build(navigationController: self.navigationController)
    attachChild(registerCoordinator)
    registerCoordinator.delegate = self

    registerCoordinator.start()
  }

  func mainFlow() {
    let mainCoordinator = mainBuildable.build(navigationController: self.navigationController)
    attachChild(mainCoordinator)
    mainCoordinator.delegate = self
    
    mainCoordinator.start()
  }
}

extension AppCoordinator: MainCoordinatingDelegate {
  func detachMain(_ coordinator: Coordinator) {
    detachChild(coordinator)

    AppData.needOnBoarding = true

    registerFlow()
  }
}

extension AppCoordinator: RegisterCoordinatingDelegate {
  func detachRegister(_ coordinator: Coordinator) {
    detachChild(coordinator)

    AppData.needOnBoarding = false

    mainFlow()
  }
}
