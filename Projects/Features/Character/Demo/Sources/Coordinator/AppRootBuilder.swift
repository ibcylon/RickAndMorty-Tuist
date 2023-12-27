//
//  AppRootBuilder.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/27.
//

import UIKit

import Core

import Character
import CharacterTesting

protocol AppRootBuildable {
  func build() -> LaunchCoordinating
}

public final class AppRootBuilder: AppRootBuildable {
  public init() { }

  public func build() -> LaunchCoordinating {

    let rootViewController = RMLaunchViewController()
    let detailBuilder = MockDetailBuilder()

    return AppCoordinator(
      rootViewControllable: rootViewController,
      mainBuildable: CharacterBuilder(detailBuildable: detailBuilder)
    )
  }
}

