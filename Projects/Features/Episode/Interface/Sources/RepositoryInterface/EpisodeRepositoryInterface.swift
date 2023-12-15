//
//  EpisodeRepositoryInterface.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation
import RxSwift

public protocol EpisodeRepositoryInterface {
  func fetchAllEpisodes(page: Int) -> Observable<RMEpisodeInfo>
  func fetchEpisodesByIDs(ids: [Int]) -> Observable<[RMEpisode]>
  func fetchSingleEpisodeByID(id: Int) -> Observable<RMEpisode>
//  func fetchCharactersByFilter(filter: RMCharacterFilter, page: Int) -> Observable<RMCharacterInfo>
}
