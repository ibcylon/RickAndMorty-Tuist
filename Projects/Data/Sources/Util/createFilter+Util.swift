//
//  createFilter+Util.swift
//  Data
//
//  Created by Kanghos on 2023/12/20.
//

import Foundation
import Domain

extension RMCharacterFilter {
  static func createCharacterFilter(items: [Filter.Item]) -> RMCharacterFilter {
    let parameterDict = items.toParameter()

    return RMCharacterFilter(
      name: parameterDict["name"]!, species: parameterDict["species"]!,
      type: parameterDict["type"]!, status: parameterDict["status"]!,
      gender: parameterDict["gender"]!
    )
  }
}

extension RMLocationFilter {
  static func createLocationFilter(items: [Filter.Item]) -> RMLocationFilter {
    let parameterDict = items.toParameter()

    return RMLocationFilter(
      name: parameterDict["name"]!,
      type: parameterDict["type"]!,
      dimension: parameterDict["dimension"]!
    )
  }
}
