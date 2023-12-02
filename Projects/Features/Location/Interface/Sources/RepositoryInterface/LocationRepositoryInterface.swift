//
//  LocationRepositoryInterface.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation
import RxSwift

public protocol LocationRepositoryInterface {
  func fetchAllLocations(page: Int) -> Observable<RMLocationInfo>
  func fetchLocationByID(ids: [Int]) -> Observable<[RMLocation]>
  func fetchSingleLocationByID(id: Int) -> Observable<RMLocation>
  func fetchLocationsByFilter(filter: RMLocationFilter, page: Int) -> Observable<RMLocationInfo>
}
