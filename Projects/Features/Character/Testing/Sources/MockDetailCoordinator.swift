//
//  MockDetailCoordinator.swift
//  CharacterTesting
//
//  Created by Kanghos on 2023/12/27.
//

import Foundation

import Domain
import Core

public final class MockDetailCoordinator: BaseCoordinator, DetailCoordinating {
  public var delegate: Domain.DetailCoordinatorDelegate?
  
  public func episodeDetailFlow(_ item: EpisodeInterface.RMEpisode) {
    RMLogger.ui.debug("epsidoe Flow")
  }
  
  public func locationDetailFlow(_ item: LocationInterface.RMLocation) {
    RMLogger.ui.debug("location Flow")
  }

  public func characterDetailFlow(_ item: RMCharacter) {
    RMLogger.ui.debug("Chracaer FLow")
  }
}
