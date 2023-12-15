//
//  RMLocation.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

// MARK: - RMLocation
public struct RMLocation: Codable {
    public let id: Int
    public let name, type, dimension: String
    public let residents: [String]
    public let url: String
    public let created: String

  public init(id: Int, name: String, type: String, dimension: String, residents: [String], url: String, created: String) {
    self.id = id
    self.name = name
    self.type = type
    self.dimension = dimension
    self.residents = residents
    self.url = url
    self.created = created
  }
}
