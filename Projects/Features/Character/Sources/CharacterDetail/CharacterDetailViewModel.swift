//
//  CharacterListViewModel.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation

import Domain
import Core

import RxCocoa
import RxSwift

public protocol CharacterDetailDelegate: AnyObject {
  func characterDetailPop()
  func characterDetailSelectEpisode(_ item: RMEpisode)
  func characterDetailSelectLocation(_ item: RMLocation)
}

public final class CharacterDetailViewModel: ViewModelType {
  private let useCase: FetchCharacterUseCaseInterface
  private let episodeUseCase: FetchEpisodeUseCaseInterface
  private let locationuseCase: FetchLocationUseCaseInterface

  private let item: RMCharacter

  public weak var delegate: CharacterDetailDelegate?

  public init(
    useCase: FetchCharacterUseCaseInterface,
    episodeUseCase: FetchEpisodeUseCaseInterface,
    locationUseCase: FetchLocationUseCaseInterface,
    item: RMCharacter
  ) {
    self.useCase = useCase
    self.episodeUseCase = episodeUseCase
    self.locationuseCase = locationUseCase
    self.item = item
  }

  deinit {
    RMLogger.cycle(name: self)
  }

  public struct Input {
    let onAppear: Driver<Void>
    let selectedLocation: Driver<Void>
    let selectedEpisode: Driver<IndexPath>
    let backButtonTap: Driver<Void>
  }

  public struct Output {
    let item: Driver<RMCharacter>
    let episodes: Driver<[RMEpisode]>
  }

  private let disposeBag = DisposeBag()

  public func transform(input: Input) -> Output {
    let onAppear = input.onAppear

    let characterItem = Driver.just(self.item)

    let episodes = characterItem
      .map { $0.episode }
      .map { episodes in
        episodes
          .compactMap { URL(string: $0) }
          .map { $0.lastPathComponent }
          .compactMap { Int($0) }
      }
      .asObservable()
      .flatMapLatest(weak: self) { owner, ids in
        owner.episodeUseCase.fetchEpisodesByIDs(ids: ids)
      }.asDriver(onErrorJustReturn: [])

    let singleLocation = input.selectedLocation
      .withLatestFrom(characterItem)
      .map { $0.location }

    let locationItem = singleLocation
      .map { $0.url }
      .compactMap { URL(string: $0) }
      .map { $0.lastPathComponent }
      .compactMap { Int($0) }
      .asObservable()
      .flatMapLatest(weak: self) { owner, id in
        owner.locationuseCase.fetchSingleLocationByID(id: id)
      }.asDriver(onErrorDriveWith: .empty())

    locationItem
      .drive(with: self) { owner, item in
        owner.delegate?.characterDetailSelectLocation(item)
      }.disposed(by: disposeBag)

    input.selectedEpisode
      .withLatestFrom(episodes) { indexPath, array in
        array[indexPath.item]
      }.drive(with: self) { owner, episode in
        owner.delegate?.characterDetailSelectEpisode(episode)
      }.disposed(by: disposeBag)

    input.backButtonTap
      .drive(with: self, onNext: { owner, _ in
        owner.delegate?.characterDetailPop()
      }).disposed(by: disposeBag)

    return Output(
      item: onAppear.withLatestFrom(characterItem),
      episodes: episodes
    )
  }
}
