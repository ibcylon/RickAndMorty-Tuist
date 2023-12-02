//
//  AppDelegate.swift
//  App
//
//  Created by Kanghos on 2023/11/26.
//
import UIKit

import Feature

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  var appCoordinator: LaunchCoordinating?

  func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //        registerDependencies()

    self.registerDependencies()
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window

    self.appCoordinator = AppRootBuilder().build()
    self.appCoordinator?.launch(window: window)

    return true
  }

  // MARK: UISceneSession Lifecycle

  func application( _ application: UIApplication,
                    configurationForConnecting connectingSceneSession: UISceneSession,
                    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application( _ application: UIApplication,
                    didDiscardSceneSessions sceneSessions: Set<UISceneSession>
  ) {}
}
