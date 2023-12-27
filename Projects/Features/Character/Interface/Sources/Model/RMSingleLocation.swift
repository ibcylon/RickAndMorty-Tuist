//
//  RMSingleLocation.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

// MARK: - Location
public struct RMSingleLocation: Codable {

  public let name: String
  public let url: String
  
  public init(name: String, url: String) {
    self.name = name
    self.url = url
  }
}
