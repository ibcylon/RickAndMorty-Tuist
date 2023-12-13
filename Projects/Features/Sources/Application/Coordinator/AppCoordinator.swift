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

final class AppCoordinator: LaunchCoordinator, AppCoordinating {

  private let mainBuildable: MainBuildable
  private let registerBuildable: RegisterBuildable

  init(
    rootViewControllable: ViewControllable,
    mainBuildable: MainBuildable,
    registerBuildable: RegisterBuildable
  ) {
    self.mainBuildable = mainBuildable
    self.registerBuildable = registerBuildable
    super.init(rootViewController: rootViewControllable)
  }

  public override func start() {
    mainFlow()
  }

  // MARK: - public
  func registerFlow() {
    let registerCoordinator = self.registerBuildable.build(rootViewControllable: self.viewControllable)
    attachChild(registerCoordinator)
    registerCoordinator.delegate = self

    registerCoordinator.start()
  }

  func mainFlow() {
    let mainCoordinator = mainBuildable.build(rootViewControllable: self.viewControllable)

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
