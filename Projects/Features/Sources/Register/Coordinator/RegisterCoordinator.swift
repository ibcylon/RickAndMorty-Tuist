//
//  MainCoordinator.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/10/29.
//

import UIKit
import Core
import Character
import CharacterInterface

final class RegisterCoordinator: BaseCoordinator, RegisterCoordinating {

  var delegate: RegisterCoordinatingDelegate?

  func attachRegister() {
    start()
  }

  override func start() {
    let viewController = RegisterViewController()
    self.navigationController.viewControllers = [viewController]
//    self.navigationController.pushViewController(viewController, animated: true)
  }
}
