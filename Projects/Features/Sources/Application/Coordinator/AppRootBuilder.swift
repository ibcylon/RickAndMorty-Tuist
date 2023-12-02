//
//  LaunchBuilder.swift
//  App
//
//  Created by Kanghos on 2023/11/30.
//

import UIKit

protocol AppRootBuildable {
  func build() -> LaunchCoordinating
}

public final class AppRootBuilder: AppRootBuildable {
  public init() { }

  public func build() -> LaunchCoordinating {

    let navigationController = UINavigationController()
    let appCoordinator = AppCoordinator(
      navigationController: navigationController,
      mainBuildable: MainBuilder(),
      registerBuildable: RegisterBuilder()
    )

    return appCoordinator
  }
}

