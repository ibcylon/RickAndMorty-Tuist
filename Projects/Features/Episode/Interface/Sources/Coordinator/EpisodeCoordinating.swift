//
//  EpisodeCoordinating.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/02.
//

import Foundation
import Core
import EpisodeInterface

public protocol EpisodeCoordinating: Coordinator {
  func episodeDetailFlow(item: RMEpisode)
}
