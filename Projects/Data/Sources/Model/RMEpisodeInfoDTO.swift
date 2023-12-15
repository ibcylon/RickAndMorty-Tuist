//
//  RMEpisodeInfoDTO.swift
//  Data
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation
import EpisodeInterface

public struct RMEpisodeInfoDTO: Codable {
  let info: Info
  let results: [RMEpisodeDTO]

  public init(info: Info, results: [RMEpisodeDTO]) {
    self.info = info
    self.results = results
  }
}

extension RMEpisodeInfoDTO {
  func toDomain() -> RMEpisodeInfo {
    RMEpisodeInfo(
      info: self.info,
      results: self.results
        .map { $0.toDomain() }
    )
  }
}
