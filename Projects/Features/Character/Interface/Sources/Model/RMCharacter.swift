//
//  RMCharacter.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

// MARK: - RMCharacter
public struct RMCharacter: Codable {
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
