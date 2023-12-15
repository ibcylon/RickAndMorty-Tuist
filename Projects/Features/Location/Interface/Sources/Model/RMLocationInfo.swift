//
//  RMLocationInfo.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

public struct RMLocationInfo: Codable {
  public let info: Info
  public let results: [RMLocation]

  public init(info: Info, results: [RMLocation]) {
    self.info = info
    self.results = results
  }
}

public struct Info: Codable {
  public let count: Int
  public let pages: Int
  public let next: String?
  public let prev: String?

  public init(count: Int, pages: Int, next: String?, prev: String?) {
    self.count = count
    self.pages = pages
    self.next = next
    self.prev = prev
  }

  public var nextPagenumber: Int? {
    guard let nextPageURLString = next,
          let queries = URLComponents(string: nextPageURLString)?.queryItems
    else {
      return nil
    }
    let item = queries
      .first(where: { item in
        item.name == "page"
      })
      .flatMap { $0.value }

    guard let value = item else {
      return nil
    }
    return Int(value)
  }
}
