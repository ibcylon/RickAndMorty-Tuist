//
//  RMEpisodeInfo.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/02.
//

import Foundation
import CharacterInterface

public struct RMEpisodeInfo: Codable {
  let info: Info
  let results: [RMEpisode]

  public init(info: Info, results: [RMEpisode]) {
    self.info = info
    self.results = results
  }
}
