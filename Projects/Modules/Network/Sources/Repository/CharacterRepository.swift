//
//  CharacterRepository.swift
//  Network
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation
import RxSwift
import CharacterInterface

public final class CharacterRepository {
  private let characterService: CharacterService

  public init(characterService: CharacterService) {
    self.characterService = characterService
  }
}

extension CharacterRepository: CharacterRepositoryInterface {
  public func fetchAllCharacters(page: Int) -> Observable<RMCharacterInfo> {
    return characterService.fetchAllCharacter()
  }
}
