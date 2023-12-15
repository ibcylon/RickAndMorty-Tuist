//
//  EpisodeCoordinating.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation
import Core

public protocol EpisodeHomeFlow {
   func episodeHomeFlow()
}

public protocol EpisodeDetailFlow {
  func episodeDetailFlow(_ item: RMEpisode)
}

public protocol EpisodeCoordinatorDelegate: AnyObject {
  func detach(_ coordinator: Coordinator)
}

public protocol EpisodeCoordinating: Coordinator, EpisodeDetailFlow, EpisodeHomeFlow {
  var delegate: EpisodeCoordinatorDelegate? { get set }
}

