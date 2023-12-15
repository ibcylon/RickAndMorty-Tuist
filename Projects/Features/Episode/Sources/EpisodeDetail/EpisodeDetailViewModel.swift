//
//  EpisodeDetailViewModel.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation

import EpisodeInterface
import CharacterInterface
import Core

import RxSwift
import RxCocoa

public protocol EpisodeDetailDelegate: AnyObject {
  func selectCharacter(_ item: RMCharacter)
  func episodeDetailPop()
}

public final class EpisodeDetailViewModel: ViewModelType {
  private let episodeUseCase: FetchEpisodeUseCaseInterface
  private let characterUseCase: FetchCharacterUseCaseInterface
  private let item: RMEpisode
  private var disposeBag = DisposeBag()

  public weak var delegate: EpisodeDetailDelegate?

  public struct Input {
    let onAppear: Driver<Void>
    let backButtonTap: Driver<Void>
    let selectedCharacter: Driver<IndexPath>
  }

  public struct Output {
    let item: Driver<RMEpisode>
    let residents: Driver<[RMCharacter]>
  }

  public init(episodeUseCase: FetchEpisodeUseCaseInterface,
       characterUseCase: FetchCharacterUseCaseInterface,
       item: RMEpisode
  ) {
    self.item = item
    self.characterUseCase = characterUseCase
    self.episodeUseCase = episodeUseCase
  }

  public func transform(input: Input) -> Output {
    let episodeItem = Driver.just(self.item)

    let residents = episodeItem
      .map { $0.characters }
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
        owner.delegate?.episodeDetailPop()
      }).disposed(by: disposeBag)

    return Output(
      item: input.onAppear.withLatestFrom(episodeItem),
      residents: residents
    )
  }
}
