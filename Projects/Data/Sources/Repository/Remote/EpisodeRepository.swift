//
//  CharacterRepository.swift
//  Network
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation
import RxSwift
import EpisodeInterface

public final class EpisodeRepository {
  private let episodeService: EpisodeService

  public init(episodeService: EpisodeService) {
    self.episodeService = episodeService
  }
}

extension EpisodeRepository: EpisodeRepositoryInterface {
  public func fetchAllEpisodes(page: Int) -> RxSwift.Observable<EpisodeInterface.RMEpisodeInfo> {
    episodeService.fetchAllEpisode(page: page)
  }

  public func fetchEpisodesByIDs(ids: [Int]) -> RxSwift.Observable<[EpisodeInterface.RMEpisode]> {
    episodeService.fetchEpisodesByIDs(ids: ids)
  }

  public func fetchSingleEpisodeByID(id: Int) -> RxSwift.Observable<EpisodeInterface.RMEpisode> {
    episodeService.fetchSingleEpisodeByID(id: id)
  }
}
