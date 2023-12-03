//
//  SceneDelegate.swift
//  App
//
//  Created by Kanghos on 2023/12/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  //  var appCoordinator: LaunchCoordinating?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: scene)
    self.window = window
    self.window?.rootViewController = UIViewController()
    self.window?.makeKeyAndVisible()

    self.window?.rootViewController?.view.backgroundColor = .yellow
    print("scenedelegate")
    //    self.appCoordinator = AppRootBuilder().build()
    //    self.appCoordinator?.launch(window: window)
  }
}
