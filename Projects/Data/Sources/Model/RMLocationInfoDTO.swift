//
//  RMLocationDTO.swift
//  Data
//
//  Created by Kanghos on 2023/12/10.
//

import Foundation

import CharacterInterface
import LocationInterface

public struct RMLocationInfoDTO: Codable {
  let info: Info
  let results: [RMLocationDTO]

  public init(info: Info, results: [RMLocationDTO]) {
    self.info = info
    self.results = results
  }
}

extension RMLocationInfoDTO {
  func toDomain() -> RMLocationInfo {
    RMLocationInfo(
      info: self.info,
      results: self.results
        .map { $0.toDomain() }
    )
  }
}
