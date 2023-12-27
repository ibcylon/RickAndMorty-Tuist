//
//  RMEpisode.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

public struct RMEpisode {
  public let id: Int
  public let name: String
  public let airDate: String
  public let episode: String
  public let characters: [String]
  public let url: String
  public let created: String

  public init(
    id: Int, name: String,
    airDate: String, episode: String,
    characters: [String], url: String,
    created: String
  ) {
    self.id = id
    self.name = name
    self.airDate = airDate
    self.episode = episode
    self.characters = characters
    self.url = url
    self.created = created
  }
}

extension RMEpisode: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  public static func == (lhs: RMEpisode, rhs: RMEpisode) -> Bool {
    lhs.id == rhs.id
  }
}

