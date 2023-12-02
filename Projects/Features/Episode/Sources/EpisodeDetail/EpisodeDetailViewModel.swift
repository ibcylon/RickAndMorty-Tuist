//
//  EpisodeDetailViewModel.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/02.
//

import Foundation
import EpisodeInterface

protocol EpisodeDetailDelegate: AnyObject {
  func pop()
}

public final class EpisodeDetailViewModel {
  private let useCase: FetchEpisodeUseCaseInterface
  private let item: RMEpisode

  var delegate: EpisodeDetailDelegate?

  init(useCase: FetchEpisodeUseCaseInterface, item: RMEpisode) {
    self.useCase = useCase
    self.item = item
  }
}
