//
//  LocationDetailViewModel.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/12/11.
//

import Foundation

import LocationInterface
import CharacterInterface
import Core

import RxSwift
import RxCocoa

public protocol LocationDetailDelegate: AnyObject {
  func selectCharacter(_ item: RMCharacter)
  func locationDetailPop()
}

public final class LocationDetailViewModel: ViewModelType {
  private let locationUseCase: FetchLocationUseCaseInterface
  private let characterUseCase: FetchCharacterUseCaseInterface
  private let item: RMLocation
  private var disposeBag = DisposeBag()

  public weak var delegate: LocationDetailDelegate?

  public struct Input {
    let onAppear: Driver<Void>
    let backButtonTap: Driver<Void>
    let selectedCharacter: Driver<IndexPath>
  }

  public struct Output {
    let item: Driver<RMLocation>
    let residents: Driver<[RMCharacter]>
  }

  public init(locationUseCase: FetchLocationUseCaseInterface,
       characterUseCase: FetchCharacterUseCaseInterface,
       item: RMLocation
  ) {
    self.item = item
    self.characterUseCase = characterUseCase
    self.locationUseCase = locationUseCase
  }

  deinit {
    RMLogger.cycle(name: self)
  }

  public func transform(input: Input) -> Output {
    let locationItem = Driver.just(self.item)
    
    let residents = locationItem
      .map { $0.residents }
      .map { residents in
        residents
          .compactMap { URL(string: $0) }
          .map { $0.lastPathComponent }
          .compactMap { Int($0) }
      }.asObservable()
      .flatMapLatest(weak: self) { owner, ids in
        owner.characterUseCase.fetchCharactersByIDs(ids: ids)
      }.asDriver(onErrorJustReturn: [])

    input.selectedCharacter
      .withLatestFrom(residents) { $1[$0.item] }
      .drive(with: self) { owner, item in
        owner.delegate?.selectCharacter(item)
      }.disposed(by: disposeBag)

    input.backButtonTap
      .drive(with: self, onNext: { owner, _ in
        owner.delegate?.locationDetailPop()
      }).disposed(by: disposeBag)

    return Output(
      item: input.onAppear.withLatestFrom(locationItem),
      residents: residents
    )
  }
}
