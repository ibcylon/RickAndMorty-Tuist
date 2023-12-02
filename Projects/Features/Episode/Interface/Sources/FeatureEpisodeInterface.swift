//
//  FeatureEpisodeInterface.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/02.
//

import Foundation
import UIKit
import RxSwift

public protocol FetchEpisodeUseCaseInterface {
  func fetchAllEpisodes(page: Int) -> Observable<RMEpisodeInfo>
}
