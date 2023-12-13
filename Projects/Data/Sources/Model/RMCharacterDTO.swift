//
//  RMCharacterDTO.swift
//  Data
//
//  Created by Kanghos on 2023/12/10.
//

import Foundation
import CharacterInterface

// MARK: - RMCharacter
public struct RMCharacterDTO: Codable {
  let id: Int
  let name, species, type: String
  let status: RMCharacterStatus
  let gender: RMGender
  let origin: RMSingleLocation
  let location: RMSingleLocation
  let image: String
  let episode: [String]
  let url: String
  let created: String
}

extension RMCharacterDTO {
  func toDomain() -> RMCharacter {
    RMCharacter(
      id: self.id,
      name: self.name,
      species: self.species,
      type: self.type,
      status: self.status,
      gender: self.gender,
      origin: self.origin,
      location: self.location,
      image: self.image,
      episode: self.episode,
      url: self.url,
      created: self.created
    )
  }
}
