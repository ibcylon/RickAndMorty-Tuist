//
//  RMFilter.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

// MARK: - RMFilter
public struct RMLocationFilter: Codable {
  let name, type, dimension: String?

  public init(name: String?, type: String?, dimension: String?) {
    self.name = name
    self.type = type
    self.dimension = dimension
  }
}

