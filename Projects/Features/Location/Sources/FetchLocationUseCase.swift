//
//  FetchLocationUseCase.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation
import Core
import RxSwift
import LocationInterface

public final class FetchRMLocationUseCase: FetchLocationUseCaseInterface {

  private let repository: LocationRepositoryInterface

  public init(repository: LocationRepositoryInterface) {
    self.repository = repository
  }

  public func fetchAllLocations(page: Int) -> Observable<RMLocationInfo> {
    repository.fetchAllLocations(page: page)
  }

  public func fetchLocationByID(ids: [Int]) -> Observable<[RMLocation]> {
    repository.fetchLocationByID(ids: ids)
  }

  public func fetchSingleLocationByID(id: Int) -> Observable<RMLocation> {
    repository.fetchSingleLocationByID(id: id)
  }

  public func fetchLocationsByFilter(filter: RMLocationFilter, page: Int) -> Observable<RMLocationInfo> {
    repository.fetchLocationsByFilter(filter: filter, page: page)
  }
}
