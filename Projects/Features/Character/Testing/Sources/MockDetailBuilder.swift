//
//  MockDetailBuilder.swift
//  CharacterTesting
//
//  Created by Kanghos on 2023/12/27.
//

import Foundation

import Domain
import Core

public final class MockDetailBuilder: DetailBuildable {
  public init() { }
  public func build(rootViewControllable: Core.ViewControllable) -> Domain.DetailCoordinating {
    MockDetailCoordinator(rootViewController: rootViewControllable)
  }
}
