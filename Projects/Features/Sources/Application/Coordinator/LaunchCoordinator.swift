//
//  LaunchRouter.swift
//  App
//
//  Created by Kanghos on 2023/11/30.
//

import UIKit
import Core

open class LaunchRouter: BaseCoordinator, LaunchCoordinating {
  public override init(navigationController: UINavigationController) {
    navigationController.viewControllers = [ RMLaunchViewController() ]

    super.init(navigationController: navigationController)
  }
  public func launch(window: UIWindow) {
    window.rootViewController = self.navigationController
    window.makeKeyAndVisible()
    
    sleep(1)
    print("launch")
    start()
  }
}

extension AppCoordinator: URLHandling {
  public func handle(_ url: URL) {
    print("Handling URL..... \(url)")
  }
}
