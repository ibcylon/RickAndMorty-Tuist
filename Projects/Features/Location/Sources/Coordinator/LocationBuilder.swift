//
//  LocationBuilder.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/12/11.
//

import Foundation
import Domain

import Core

public final class LocationBuilder: LocationBuildable {

  private let detailBuildable: DetailBuildable

  public init(detailBuildable: DetailBuildable) {
    self.detailBuildable = detailBuildable
  }
  public func build(rootViewControllable: ViewControllable) -> LocationCoordinating {

    let coordinator = LocationCoordinator(
      rootViewController: rootViewControllable,
      detailBuildable: detailBuildable
    )

    return coordinator
  }
}
