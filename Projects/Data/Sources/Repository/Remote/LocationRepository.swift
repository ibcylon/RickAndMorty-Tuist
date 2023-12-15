//
//  locationRepository.swift
//  Network
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation
import RxSwift
import LocationInterface

public final class LocationRepository {
  private let locationService: LocationService

  public init(locationService: LocationService) {
    self.locationService = locationService
  }
}

extension LocationRepository: LocationRepositoryInterface {
  public func fetchAllLocations(page: Int) -> Observable<RMLocationInfo> {
    return locationService.fetchAllLocation(page: page)
  }

  public func fetchSingleLocationByID(id: Int) -> Observable<RMLocation> {
    locationService.fetchSingleLocationByID(id: id)
  }
}
