//
//  CharacterListViewModel.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation
import CharacterInterface

protocol CharacterDetailDelegate: AnyObject {
  func pop()
}

public final class CharacterDetailViewModel {
  private let useCase: FetchCharacterUseCaseInterface
  private let item: RMCharacter

  var delegate: CharacterDetailDelegate?

  init(useCase: FetchCharacterUseCaseInterface, item: RMCharacter) {
    self.useCase = useCase
    self.item = item
  }
}
