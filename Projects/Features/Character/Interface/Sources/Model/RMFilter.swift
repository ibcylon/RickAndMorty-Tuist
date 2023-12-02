//
//  RMFilter.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

// MARK: - RMFilter
public struct RMCharacterFilter: Codable {
  let name, species, type: String
  let status: RMCharacterStatus
  let gender: RMGender
}

