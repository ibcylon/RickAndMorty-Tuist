//
//  RMCharacterDTO.swift
//  Data
//
//  Created by Kanghos on 2023/12/10.
//

import Foundation

import CharacterInterface

public struct RMCharacterInfoDTO: Codable {
  let info: Info
  let results: [RMCharacterDTO]

  public init(info: Info, results: [RMCharacterDTO]) {
    self.info = info
    self.results = results
  }
}

extension RMCharacterInfoDTO {
  func toDomain() -> RMCharacterInfo {
    RMCharacterInfo(
      info: self.info,
      results: self.results
        .map { $0.toDomain() }
    )
  }
}
