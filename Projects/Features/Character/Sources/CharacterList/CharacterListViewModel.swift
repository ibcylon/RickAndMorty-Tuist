//
//  CharacterListViewModel.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation
import CharacterInterface

protocol CharacterSearchDelegate: AnyObject {
  func logout()
  func presentItem(item: RMCharacter)
}

public final class CharacterListViewModel {
  private let useCase: FetchCharacterUseCaseInterface

  var delegate: CharacterSearchDelegate?

  init(useCase: FetchCharacterUseCaseInterface) {
    self.useCase = useCase
  }
  
}
