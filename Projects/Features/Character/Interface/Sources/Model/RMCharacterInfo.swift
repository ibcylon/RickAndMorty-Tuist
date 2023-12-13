//
//  RMInfo.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

public struct RMCharacterInfo {
  public let info: Info
  public let results: [RMCharacter]

  public init(info: Info, results: [RMCharacter]) {
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
}
