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
  func build() -> RegisterCoordinating {

    let navigation = NavigationControllable()
    let coordinator = RegisterCoordinator(rootViewController: navigation)

    return coordinator
  }
}
