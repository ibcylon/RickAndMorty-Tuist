//
//  LaunchCoordinating.swift
//  Feature
//
//  Created by Kanghos on 2023/12/01.
//

import UIKit
import Core

public protocol LaunchCoordinating: Coordinator {
  func launch(window: UIWindow)
}

public protocol URLHandling {
  func handle(_ url: URL)
}
