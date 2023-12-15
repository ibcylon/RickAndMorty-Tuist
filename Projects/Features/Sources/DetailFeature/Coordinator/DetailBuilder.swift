//
//  DetailBuilder.swift
//  Feature
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation

import Core
import Domain

public final class DetailBuilder: DetailBuildable {

  public func build(rootViewControllable: ViewControllable) -> DetailCoordinating {
    DetailCoordinator(rootViewController: rootViewControllable)
  }
}
