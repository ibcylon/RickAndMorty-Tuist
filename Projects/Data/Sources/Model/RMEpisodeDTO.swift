//
//  RMEpisodeDTO.swift
//  Data
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation
import EpisodeInterface

public struct RMEpisodeDTO: Codable {
  public let id: Int
  public let name: String
  public let air_date: String
  public let episode: String
  public let characters: [String]
  public let url: String
  public let created: String

  public init(
    id: Int, name: String,
    air_date: String, episode: String,
    characters: [String], url: String,
    created: String
  ) {
    self.id = id
    self.name = name
    self.air_date = air_date
    self.episode = episode
    self.characters = characters
    self.url = url
    self.created = created
  }

  public func toDomain() -> RMEpisode {
    RMEpisode(
      id: id,
      name: name,
      airDate: air_date,
      episode: episode,
      characters: characters,
      url: url,
      created: created
    )
  }
}
