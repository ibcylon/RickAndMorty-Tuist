//
//  RMLocationInfo.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

public struct RMLocationInfo: Codable {
  let info: Info
  let results: [RMLocation]
}

struct Info: Codable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}

