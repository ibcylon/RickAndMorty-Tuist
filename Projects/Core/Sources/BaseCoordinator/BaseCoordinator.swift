//
//  Coordinator.swift
//  Core
//
//  Created by Kanghos on 2023/11/26.
//

import UIKit

public protocol Coordinator: AnyObject {
  var viewControllable: ViewControllable { get }
  var childCoordinators: [Coordinator] { get set }

  func start()
  func attachChild(_ child: Coordinator)
  func detachChild(_ child: Coordinator)
}

open class BaseCoordinator: Coordinator {
  public let viewControllable: ViewControllable
  public var childCoordinators: [Coordinator]
  public init(rootViewController: ViewControllable) {
    self.viewControllable = rootViewController
    self.childCoordinators = []

    RMLogger.ui.debug("\(#function) \(type(of: self))")
  }

  deinit {
    RMLogger.ui.info("\(#function) \(type(of: self))")
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
