//
//  FetchCharacterUseCase.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation
import Core
import RxSwift
import CharacterInterface

public final class FetchRMCharacterUseCase: FetchCharacterUseCaseInterface {

  private let repository: CharacterRepositoryInterface

  public init(repository: CharacterRepositoryInterface) {
    self.repository = repository
  }

  public func fetchAllCharacters(page: Int) -> Observable<RMCharacterInfo> {
    repository.fetchAllCharacters(page: page)
  }
  public func fetchSingleCharacterByID(id: Int) -> Observable<RMCharacter> {
    repository.fetchSingleCharacterByID(id: id)
  }

  public func fetchCharactersByIDs(ids: [Int]) -> Observable<[RMCharacter]> {
    repository.fetchCharactersByIDs(ids: ids)
  }
  public func fetchCharactersByFilter(filter: RMCharacterFilter, page: Int) -> Observable<RMCharacterInfo> {
    repository.fetchCharactersByFilter(filter: filter, page: page)
  }
}
