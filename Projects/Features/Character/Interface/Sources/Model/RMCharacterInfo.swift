//
//  RMInfo.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

public struct RMCharacterInfo: Codable {
  let info: Info
  let results: [RMCharacter]

  public init(info: Info, results: [RMCharacter]) {
    self.info = info
    self.results = results
  }
}

public struct Info: Codable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?

  public init(count: Int, pages: Int, next: String?, prev: String?) {
    self.count = count
    self.pages = pages
    self.next = next
    self.prev = prev
  }
}
