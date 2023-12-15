//
//  EpisodeBuilder.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation
import Core
import Domain

public final class EpisodeBuilder: EpisodeBuildable {
  private let detailBuildable: DetailBuildable

  public init(detailBuildable: DetailBuildable) {
    self.detailBuildable = detailBuildable
  }

  public func build(rootViewControllable: ViewControllable) -> EpisodeCoordinating {

    return EpisodeCoordinator(
      rootViewControllable: rootViewControllable,
      detailBuildable: detailBuildable
    )
  }
}
