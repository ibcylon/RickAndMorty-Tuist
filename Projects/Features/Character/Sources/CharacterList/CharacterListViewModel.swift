//
//  CharacterListViewModel.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation

import RxSwift
import RxCocoa

import Core
import CharacterInterface

protocol CharacterSearchDelegate: AnyObject {
  func logout()
  func presentItem(item: RMCharacter)
}

public final class CharacterListViewModel: ViewModelType {
  private let useCase: FetchCharacterUseCaseInterface

  var delegate: CharacterSearchDelegate?

  init(useCase: FetchCharacterUseCaseInterface) {
    self.useCase = useCase
  }
  
  public struct Input {
    let onAppear: Driver<Void>
    let buttonTap: Driver<IndexPath>
    let paging: Driver<Void>
  }

  public struct Output {
    let route: Driver<Void>
    let characterArray: Driver<[RMCharacter]>
  }
}

extension CharacterListViewModel {
  public func transform(input: Input) -> Output {
    let onAppear = input.onAppear

    let info = onAppear
      .flatMapLatest { [weak self] in
        guard let self = self else { fatalError("self is nil") }
        return self.useCase.fetchAllCharacters(page: 1)
          .asDriver(onErrorDriveWith: .empty())
      }

    let list = info.map { $0.results }

    let route = input.buttonTap
      .withLatestFrom(list) { $1[$0.item] }
      .do(onNext: { [weak self] item in
        self?.delegate?.presentItem(item: item)
      }).map { _ in }

    return Output(
      route: route,
      characterArray: list
    )
  }
}
