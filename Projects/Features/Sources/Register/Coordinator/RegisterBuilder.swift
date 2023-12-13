//
//  MainBuilder.swift
//  Feature
//
//  Created by Kanghos on 2023/11/27.
//

import UIKit

import Core
import Character

public final class RegisterBuilder: RegisterBuildable {
  func build(rootViewControllable: Core.ViewControllable) -> RegisterCoordinating {
    let coordinator = RegisterCoordinator(rootViewController: rootViewControllable)

    return coordinator
  }
}
