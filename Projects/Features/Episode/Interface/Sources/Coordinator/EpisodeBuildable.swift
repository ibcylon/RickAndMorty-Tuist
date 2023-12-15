//
//  EpisodeBuildable.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation
import Core

public protocol EpisodeBuildable {
  func build(rootViewControllable: ViewControllable) -> EpisodeCoordinating
}
