//
//  RMFilter.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

// MARK: - RMFilter
public struct RMCharacterFilter: Codable {
  let name, species, type: String?
  let status: String?
  let gender: String?

  public init(name: String?, species: String?, type: String?, status: String?, gender: String?) {
    self.name = name
    self.species = species
    self.type = type
    self.status = status
    self.gender = gender
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(self.name, forKey: .name)
    try container.encodeIfPresent(self.species, forKey: .species)
    try container.encodeIfPresent(self.type, forKey: .type)
    try container.encodeIfPresent(self.status, forKey: .status)
    try container.encodeIfPresent(self.gender, forKey: .gender)
  }
}

