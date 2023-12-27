//
//  MockCharacterRepository.swift
//  CharacterTesting
//
//  Created by Kanghos on 2023/12/27.
//

import Foundation

import CharacterInterface

import RxSwift

public final class MockCharacterRepository {
  public init() { }
}

extension MockCharacterRepository: CharacterRepositoryInterface {
  public func fetchAllCharacters(page: Int) -> RxSwift.Observable<CharacterInterface.RMCharacterInfo> {
    .just(.mock)
  }
  
  public func fetchCharactersByIDs(ids: [Int]) -> RxSwift.Observable<[CharacterInterface.RMCharacter]> {
    .just([.mock])
  }
  
  public func fetchSingleCharacterByID(id: Int) -> RxSwift.Observable<CharacterInterface.RMCharacter> {
    .just(.mock)
  }
  
  public func fetchCharactersByFilter(filter: CharacterInterface.RMCharacterFilter, page: Int) -> RxSwift.Observable<CharacterInterface.RMCharacterInfo> {
    .just(.mock)
  }
}

extension RMCharacterInfo {
  static let mock: Self = RMCharacterInfo(
    info:
      Info(count: 0, pages: 1, next: nil, prev: nil),
    results: [.mock])
}

extension RMCharacter {
  static let mock: Self =
  RMCharacter(
    id: 1, name: "Mock", species: "mock",
              type: "mock", status: .alive,
    gender: .unknown, 
    origin: .mock,
    location: .mock,
    image: "",
    episode: [],
    url: "",
    created: DateFormatter().string(from: Date())
  )
}

extension RMSingleLocation {
  static let mock = RMSingleLocation(name: "mock", url: "")
}
