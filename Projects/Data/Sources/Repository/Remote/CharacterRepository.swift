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
  
  public func fetchCharactersByIDs(ids: [Int]) -> Observable<[RMCharacter]> {
    return characterService.fetchCharactersByIDs(ids: ids)
  }
  
  public func fetchAllCharacters(page: Int) -> Observable<RMCharacterInfo> {
    return characterService.fetchAllCharacter(page: page)
  }

  public func fetchSingleCharacterByID(id: Int) -> Observable<RMCharacter> {
    characterService.fetchSingleCharacterByID(id: id)
  }

  public func fetchCharactersByFilter(filter: RMCharacterFilter, page: Int) -> Observable<RMCharacterInfo> {
    characterService.fetchCharactersByFilter(filter: filter, page: page)
  }
}
