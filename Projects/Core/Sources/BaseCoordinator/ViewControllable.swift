//
//  ViewControllable.swift
//  Core
//
//  Created by Kanghos on 2023/12/01.
//

import UIKit

public protocol ViewControllable {
  var uiController: UIViewController { get }
}

public extension ViewControllable where Self: UIViewController {
  var uiController: UIViewController { self }
}

public extension ViewControllable {
  func setViewControllers(_ viewControllerables: [ViewControllable]) {
    if let nav = self.uiController as? UINavigationController {
      nav.setViewControllers(viewControllerables.map(\.uiController), animated: false)
    } else {
      self.uiController.navigationController?.setViewControllers(viewControllerables.map(\.uiController), animated: false)
    }
  }

  func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
    if let nav = self.uiController as? UINavigationController {
      nav.pushViewController(viewControllable.uiController, animated: animated)
    } else {
      self.uiController.navigationController?.pushViewController(viewControllable.uiController, animated: animated)
    }
  }

  func popViewController(animated: Bool) {
    if let nav = self.uiController as? UINavigationController {
      nav.popViewController(animated: animated)
    } else {
      self.uiController.navigationController?.popViewController(animated: animated)
    }
  }
}
