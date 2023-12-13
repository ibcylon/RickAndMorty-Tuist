//
//  RMLocationInfo.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation
import CharacterInterface

public struct RMLocationInfo: Codable {
  public let info: Info
  public let results: [RMLocation]

  public init(info: Info, results: [RMLocation]) {
    self.info = info
    self.results = results
  }
}

