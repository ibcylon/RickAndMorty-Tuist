//
//  FeatureLocationInterface.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/11/19.
//

import Foundation
import Core
import UIKit
import RxSwift

public protocol FetchLocationUseCaseInterface {
  func fetchAllLocations(page: Int) -> Observable<RMLocationInfo>
//  func fetchLocationByID(ids: [Int]) -> Observable<[RMLocation]>
  func fetchSingleLocationByID(id: Int) -> Observable<RMLocation>
//  func fetchLocationsByFilter(filter: RMLocationFilter, page: Int) -> Observable<RMLocationInfo>
}
