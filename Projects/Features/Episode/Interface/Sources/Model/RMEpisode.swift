//
//  RMEpisode.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

// MARK: - RMCharacter
public struct RMEpisode: Codable {
  let id: Int
  let name, episode: String
  let air_date: String
  let characters: [String]
  let url: String
  let created: String
}
