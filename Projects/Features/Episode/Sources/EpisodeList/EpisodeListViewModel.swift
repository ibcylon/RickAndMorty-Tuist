//
//  CharacterListViewModel.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation
import EpisodeInterface

protocol EpisodeSearchDelegate: AnyObject {
  func presentItem(item: RMEpisode)
}

public final class EpisodeListViewModel {
  private let useCase: FetchEpisodeUseCaseInterface

  var delegate: EpisodeSearchDelegate?

  init(useCase: FetchEpisodeUseCaseInterface) {
    self.useCase = useCase
  }

}
