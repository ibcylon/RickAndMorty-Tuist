//
//  LaunchBuilder.swift
//  App
//
//  Created by Kanghos on 2023/11/30.
//

import UIKit

import Core

protocol AppRootBuildable {
  func build() -> LaunchCoordinating
}

public final class AppRootBuilder: AppRootBuildable {
  public init() { }

  public func build() -> LaunchCoordinating {

    let rootViewController = RMLaunchViewController()
    var option: LaunchingOption {
      AppData.needOnBoarding ? LaunchingOption.auth : LaunchingOption.main
    }

    return AppCoordinator(
      rootViewControllable: rootViewController,
      mainBuildable: MainBuilder(),
      registerBuildable: RegisterBuilder(),
      options: option
    )
  }
}

