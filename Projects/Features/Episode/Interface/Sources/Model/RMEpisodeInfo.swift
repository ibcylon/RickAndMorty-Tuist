//
//  RMEpisodeInfo.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation

public struct RMEpisodeInfo {
  public let info: Info
  public let results: [RMEpisode]

  public init(info: Info, results: [RMEpisode]) {
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
