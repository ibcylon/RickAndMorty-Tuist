//
//  FeatureCharacterInterface.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/19.
//

import Foundation
import UIKit
import RxSwift

public protocol FetchCharacterUseCaseInterface {
  func fetchAllCharacters(page: Int) -> Observable<RMCharacterInfo>
  func fetchSingleCharacterByID(id: Int) -> Observable<RMCharacter>
  func fetchCharactersByIDs(ids: [Int]) -> Observable<[RMCharacter]>
//  func fetchCharactersByFilter(filter: RMCharacterFilter, page: Int) -> Observable<RMCharacterInfo>
}
