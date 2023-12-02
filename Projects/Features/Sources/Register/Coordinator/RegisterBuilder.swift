//
//  MainBuilder.swift
//  Feature
//
//  Created by Kanghos on 2023/11/27.
//

import UIKit
import Character

public final class RegisterBuilder: RegisterBuildable {

  func build(navigationController: UINavigationController) -> RegisterCoordinating {
    let coordinator = RegisterCoordinator(navigationController: navigationController)

    return coordinator
  }
}
