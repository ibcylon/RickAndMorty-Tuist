//
//  CharacterListViewModel.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation

import CharacterInterface
import Core

import RxCocoa
import RxSwift

protocol CharacterDetailDelegate: AnyObject {
  func pop()
}

public final class CharacterDetailViewModel: ViewModelType {
  private let useCase: FetchCharacterUseCaseInterface
  private let item: RMCharacter

  var delegate: CharacterDetailDelegate?

  init(useCase: FetchCharacterUseCaseInterface, item: RMCharacter) {
    self.useCase = useCase
    self.item = item
  }

  public struct Input {
    let onAppear: Driver<Void>
    let backButtonTap: Driver<Void>
  }

  public struct Output {
    let route: Driver<Void>
    let item: Driver<RMCharacter>
  }

  public func transform(input: Input) -> Output {
    let onAppear = input.onAppear
    
    let characterItem = Driver.just(self.item)

    let route = input.backButtonTap
      .do(onNext: { [weak self] in
        self?.delegate?.pop()
      })

    return Output(
      route: route,
      item: onAppear.withLatestFrom(characterItem)
    )
  }
}
