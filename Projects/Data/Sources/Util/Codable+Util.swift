//
//  Codable+Util.swift
//  Data
//
//  Created by Kanghos on 2023/12/20.
//

import Foundation

extension Encodable {
  func toDictionary() -> [String: Any] {
    guard
      let data = try? JSONEncoder().encode(self),
      let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
    else {
      return [:]
    }
    return dictionary
  }
}
