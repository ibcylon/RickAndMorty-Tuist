//
//  DetailCoordinator.swift
//  Feature
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit
import Core
import Domain
import Character
import Location
import Episode

public final class DetailCoordinator: BaseCoordinator, DetailCoordinating {

  @Injected var characterUseCase: FetchCharacterUseCaseInterface
  @Injected var episodeUseCase: FetchEpisodeUseCaseInterface
  @Injected var locationUseCase: FetchLocationUseCaseInterface

  public weak var delegate: DetailCoordinatorDelegate?

  public override func start() {
    
  }

  // MARK: Private

  public func characterDetailFlow(_ item: RMCharacter) {

    let viewModel = CharacterDetailViewModel(
      useCase: characterUseCase,
      episodeUseCase: episodeUseCase, 
      locationUseCase: locationUseCase,
      item: item)
    viewModel.delegate = self

    let viewController = CharacterDetailViewController(viewModel: viewModel)

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func episodeDetailFlow(_ item: RMEpisode) {
    let viewModel = EpisodeDetailViewModel(
      episodeUseCase: episodeUseCase,
      characterUseCase: characterUseCase,
      item: item
    )
    viewModel.delegate = self

    let viewController = EpisodeDetailViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func locationDetailFlow(_ item: RMLocation) {
    let viewModel = LocationDetailViewModel(
      locationUseCase: locationUseCase,
      characterUseCase: characterUseCase,
      item: item)
    viewModel.delegate = self

    let viewController = LocationDetailViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }
}

extension DetailCoordinator: CharacterDetailDelegate {
  public func characterDetailSelectLocation(_ item: LocationInterface.RMLocation) {
    locationDetailFlow(item)
  }
  
  public func characterDetailPop() {
    self.viewControllable.popViewController(animated: true)
    self.delegate?.detach(coordinator: self)
  }
  public func characterDetailSelectEpisode(_ item: RMEpisode) {
    episodeDetailFlow(item)
  }
}

extension DetailCoordinator: LocationDetailDelegate {
  public func selectCharacter(_ item: CharacterInterface.RMCharacter) {
    characterDetailFlow(item)
  }
  
  public func locationDetailPop() {
    self.viewControllable.popViewController(animated: true)
    self.delegate?.detach(coordinator: self)
  }
}

extension DetailCoordinator: EpisodeDetailDelegate {
  public func episodeDetailPop() {
    self.viewControllable.popViewController(animated: true)
    self.delegate?.detach(coordinator: self)
  }
}



