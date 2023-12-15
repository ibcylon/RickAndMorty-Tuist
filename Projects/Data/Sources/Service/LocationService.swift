//
//  LocationService.swift
//  Network
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation

import RxSwift

import Networks
import LocationInterface

public protocol LocationService {
  func fetchAllLocation(page: Int) -> Observable<RMLocationInfo>
  func fetchSingleLocationByID(id: Int) -> Observable<RMLocation>
}

public class DefaultLocationService: LocationService {
  private let client: HTTPClient
  private let endPoint: APIComponent

  public init(client: HTTPClient = URLSession.shared, endPoint: APIComponent) {
    self.client = client
    self.endPoint = endPoint
  }

  public func fetchAllLocation(page: Int) -> Observable<RMLocationInfo> {
    let request = RequestWithURL(url: endPoint.url(page: page)).request()

    return perform(request, type: RMLocationInfoDTO.self)
      .map { $0.toDomain() }
  }

  public func fetchSingleLocationByID(id: Int) -> Observable<RMLocation> {
    let request = RequestWithURL(url: endPoint.url(id: id)).request()

    return perform(request, type: RMLocationDTO.self)
      .map { $0.toDomain() }
  }

  // MARK: - private

  private func perform<T: Decodable>(_ request: URLRequest, type: T.Type) -> Observable<T> {
    return .create { [weak self] observer in

      self?.client.perform(request) { result in
        switch result {
        case .success(let response):
          do {
            let (data, httpResponse) = response
            let info = try RMDefaultMapper.map(data: data, response: httpResponse, type: type)
            observer.onNext(info)
          } catch let error {
            observer.onError(error)
          }
        case .failure(let error):
          observer.onError(error)
        }
      }
      return Disposables.create {
      }
    }
  }
}
