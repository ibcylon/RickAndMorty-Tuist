//
//  CharacterRepositoryInterface.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation
import RxSwift

public protocol CharacterRepositoryInterface {
  func fetchAllCharacters(page: Int) -> Observable<RMCharacterInfo>
  func fetchCharactersByIDs(ids: [Int]) -> Observable<[RMCharacter]>
  func fetchSingleCharacterByID(id: Int) -> Observable<RMCharacter>
//  func fetchCharactersByFilter(filter: RMCharacterFilter, page: Int) -> Observable<RMCharacterInfo>
}
