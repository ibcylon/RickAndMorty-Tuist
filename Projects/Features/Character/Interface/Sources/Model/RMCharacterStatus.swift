//
//  RMCharacterStatus.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

public enum RMCharacterStatus: String, Codable, CaseIterable {
  case alive = "Alive"
  case dead = "Dead"
  case unknown = "unknown"
}
