//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/09.
//

import Foundation

public final class RMCharacterCollectionViewCellViewModel {
  private(set) var name: String
  private let status: RMCharacterStatus
  private(set) var image: String

  public init(_ item: RMCharacter) {
    self.name = item.name
    self.status = item.status
    self.image = item.image
  }
}

public extension RMCharacterCollectionViewCellViewModel {
  var statusText: String {
    return status.rawValue
  }
}
