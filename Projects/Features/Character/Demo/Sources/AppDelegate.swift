//
//  AppDelegate.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/27.
//

import UIKit

import Core

import Character
import CharacterInterface
import CharacterTesting

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    registerDependencies()
    return true
  }

  // MARK: UISceneSession Lifecycle
  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
}

extension AppDelegate {
  var container: DIContainer {
    DIContainer.shared
  }

  func registerDependencies() {

    container.register(
      interface: FetchCharacterUseCaseInterface.self,
      implement: {
        FetchRMCharacterUseCase(
          repository: MockCharacterRepository()
        )
      }
    )
  }
}

