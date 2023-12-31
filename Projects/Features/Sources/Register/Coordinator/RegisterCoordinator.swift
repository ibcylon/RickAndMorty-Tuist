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

  weak var delegate: RegisterCoordinatingDelegate?

  override func start() {
    attachRegister()
  }

  func attachRegister() {
    replaceWindowRootViewController(rootViewController: self.viewControllable)
    registerFlow()
  }

  func detach() {
    self.delegate?.detachRegister(self)
  }

  func registerFlow() {
    let vc = RegisterViewController()
    vc.delegate = self

    self.viewControllable.setViewControllers([vc]) 
  }
}

extension RegisterCoordinator: RegisterViewDelegate {
  func finishLogin() {
    detach()
  }
}
