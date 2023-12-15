//
//  SceneDelegate+Register.swift
//  App
//
//  Created by Kanghos on 2023/11/26.
//

import UIKit

import Core
import Data

import Feature
import Networks
import CharacterInterface
import Character
import Location
import LocationInterface
import EpisodeInterface
import Episode

extension AppDelegate {
  var container: DIContainer {
    DIContainer.shared
  }

  func registerDependencies() {
    
    container.register(
      interface: FetchCharacterUseCaseInterface.self,
      implement: {
        FetchRMCharacterUseCase(
          repository: CharacterRepository(
            characterService: DefaultCharacterService(endPoint: APIComponent(endPoint: .character)))
        )
      }
    )

    container.register(
      interface: FetchLocationUseCaseInterface.self,
      implement: {
        FetchRMLocationUseCase(
          repository: LocationRepository(
            locationService: DefaultLocationService(endPoint: APIComponent(endPoint: .location)))
        )
      }
    )

    container.register(
      interface: FetchEpisodeUseCaseInterface.self,
      implement: {
        FetchRMEpisodeUseCase(
          repository: EpisodeRepository(
            episodeService: DefaultEpisodeService(endPoint: APIComponent(endPoint: .episode)))
        )
      }
    )
  }
}
