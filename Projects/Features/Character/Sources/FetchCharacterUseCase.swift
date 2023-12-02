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
}
