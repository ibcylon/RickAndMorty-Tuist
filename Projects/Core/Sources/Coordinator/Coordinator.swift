//
//  Coordinator.swift
//  Core
//
//  Created by Kanghos on 2023/11/26.
//

import UIKit

public protocol Coordinator: AnyObject {
  var navigationController: UINavigationController { get }
  var childCoordinators: [Coordinator] { get set }

  func start()
  func attachChild(_ child: Coordinator)
  func detachChild(_ child: Coordinator)
}

open class BaseCoordinator: Coordinator {
  public let navigationController: UINavigationController
  public var childCoordinators: [Coordinator]
  public init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.childCoordinators = []
  }

  open func start() {

  }

  public func attachChild(_ child: Coordinator) {
    self.childCoordinators.append(child)
  }

  public func detachChild(_ child: Coordinator) {
    self.childCoordinators = self.childCoordinators.filter { $0 !== child }
  }
}
