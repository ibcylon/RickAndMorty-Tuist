//
//  FeatureEpisodeUseCase.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/02.
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
    self.repository.fetchAllEpisodes(page: page)
  }
}
