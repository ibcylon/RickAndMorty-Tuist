//
//  RMCharacter.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

// MARK: - RMCharacter
public struct RMCharacter {
  public let id: Int
  public let name, species, type: String
  public let status: RMCharacterStatus
  public let gender: RMGender
  public let origin: RMSingleLocation
  public let location: RMSingleLocation
  public let image: String
  public let episode: [String]
  public let url: String
  public let created: String

  public init(id: Int, name: String, species: String, type: String, status: RMCharacterStatus, gender: RMGender, origin: RMSingleLocation, location: RMSingleLocation, image: String, episode: [String], url: String, created: String) {
    self.id = id
    self.name = name
    self.species = species
    self.type = type
    self.status = status
    self.gender = gender
    self.origin = origin
    self.location = location
    self.image = image
    self.episode = episode
    self.url = url
    self.created = created
  }
}

extension RMCharacter: Hashable {
  public static func == (lhs: CharacterInterface.RMCharacter, rhs: CharacterInterface.RMCharacter) -> Bool {
    lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

