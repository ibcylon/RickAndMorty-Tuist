//
//  RMLocationDTO.swift
//  Data
//
//  Created by Kanghos on 2023/12/11.
//

import Foundation
import LocationInterface

// MARK: - RMLocation
public struct RMLocationDTO: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}

extension RMLocationDTO {
  func toDomain() -> RMLocation {
    RMLocation(
      id: self.id,
      name: self.name,
      type: self.type,
      dimension: self.dimension,
      residents: self.residents,
      url: self.url,
      created: self.created)
  }
}
