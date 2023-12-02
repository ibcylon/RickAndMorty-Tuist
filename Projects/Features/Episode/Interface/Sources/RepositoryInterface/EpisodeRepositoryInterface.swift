//
//  EpisodeRepositoryInterface.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/02.
//

import Foundation
import RxSwift

public protocol EpisodeRepositoryInterface {
  func fetchAllEpisodes(page: Int) -> Observable<RMEpisodeInfo>
}
