//
//  FeatureEpisodeInterface.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation
import Core
import UIKit
import RxSwift

public protocol FetchEpisodeUseCaseInterface {
  func fetchAllEpisodes(page: Int) -> Observable<RMEpisodeInfo>
  func fetchEpisodesByIDs(ids: [Int]) -> Observable<[RMEpisode]>
  func fetchSingleEpisodeByID(id: Int) -> Observable<RMEpisode>
//  func fetchLocationsByFilter(filter: RMLocationFilter, page: Int) -> Observable<RMLocationInfo>
}
