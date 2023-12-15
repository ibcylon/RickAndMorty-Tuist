//
//  Entity+Hashable.swift
//  Domain
//
//  Created by Kanghos on 2023/12/15.
//

import Foundation

import CharacterInterface
import EpisodeInterface
import LocationInterface

extension RMEpisode: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  public static func == (lhs: RMEpisode, rhs: RMEpisode) -> Bool {
    lhs.id == rhs.id
  }
}
