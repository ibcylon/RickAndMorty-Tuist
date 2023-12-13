//
//  LocationBuilder.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/12/11.
//

import Foundation
import LocationInterface

import Core

public final class LocationBuilder: LocationBuildable {
  public func build(rootViewControllable: ViewControllable) -> LocationCoordinating {

    let coordinator = LocationCoordinator()

    return coordinator
  }
}
