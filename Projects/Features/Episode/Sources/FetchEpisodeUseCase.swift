//
//  FetchEpisodeUseCase.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation
import Core
import RxSwift
import EpisodeInterface

public final class FetchRMEpisodeUseCase: FetchEpisodeUseCaseInterface {

  private let repository: EpisodeRepositoryInterface

  public init(repository: EpisodeRepositoryInterface) {
    self.repository = repository
  }

  public func fetchAllEpisodes(page: Int) -> Observable<RMEpisodeInfo> {
    repository.fetchAllEpisodes(page: page)
  }
  public func fetchSingleEpisodeByID(id: Int) -> Observable<RMEpisode> {
    repository.fetchSingleEpisodeByID(id: id)
  }

  public func fetchEpisodesByIDs(ids: [Int]) -> Observable<[RMEpisode]> {
    repository.fetchEpisodesByIDs(ids: ids)
  }
}
