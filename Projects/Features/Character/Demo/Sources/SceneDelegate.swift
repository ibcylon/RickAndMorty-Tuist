//
//  SceneDelegate.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/27.
//

import UIKit

import Core

//  var appCoordinator: LaunchCoordinating?
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
//    self.appCoordinator = AppRootBuilder().build()
//    self.appCoordinator?.launch(window: window)
  }
}
