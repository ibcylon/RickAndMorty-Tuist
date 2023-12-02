//
//  SceneDelegate.swift
//  App
//
//  Created by Kanghos on 2023/11/26.
//

import UIKit

import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  var appCoordinator: LaunchCoordinating?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    let window = UIWindow(windowScene: scene)
    self.window = window

    print("scenedelegate")
    self.appCoordinator = AppRootBuilder().build()
    self.appCoordinator?.launch(window: window)
    
//    registerDependencies()
  }

  func sceneDidDisconnect(_ scene: UIScene) {}

  func sceneDidBecomeActive(_ scene: UIScene) {}

  func sceneWillResignActive(_ scene: UIScene) {}

  func sceneWillEnterForeground(_ scene: UIScene) {}

  func sceneDidEnterBackground(_ scene: UIScene) {}
}
