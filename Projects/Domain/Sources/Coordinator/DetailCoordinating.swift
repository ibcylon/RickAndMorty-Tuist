//
//  CharacterDetailCoordinating.swift
//  Domain
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation
//
import Core
import CharacterInterface

public protocol DetailCoordinatorDelegate: AnyObject {
  func detach(coordinator: Coordinator)
}

public protocol DetailCoordinating: Coordinator, CharacterDetailFlow, EpisodeDetailFlow, LocationDetailFlow {
  var delegate: DetailCoordinatorDelegate? { get set }
}
