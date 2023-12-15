//
//  EpisodeService.swift
//  Data
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation

import RxSwift

import Networks
import EpisodeInterface

public protocol EpisodeService {
  func fetchAllEpisode(page: Int) -> Observable<RMEpisodeInfo>
  func fetchSingleEpisodeByID(id: Int) -> Observable<RMEpisode>
  func fetchEpisodesByIDs(ids: [Int]) -> Observable<[RMEpisode]>
}

public class DefaultEpisodeService: EpisodeService {
  private let client: HTTPClient
  private let endPoint: APIComponent

  public init(client: HTTPClient = URLSession.shared, endPoint: APIComponent) {
    self.client = client
    self.endPoint = endPoint
  }

  public func fetchAllEpisode(page: Int) -> Observable<RMEpisodeInfo> {
    let request = RequestWithURL(url: endPoint.url(page: page)).request()

    return perform(request, type: RMEpisodeInfoDTO.self)
      .map { $0.toDomain() }
  }

  public func fetchSingleEpisodeByID(id: Int) -> Observable<RMEpisode> {
    let request = RequestWithURL(url: endPoint.url(id: id)).request()

    return perform(request, type: RMEpisodeDTO.self)
      .map { $0.toDomain() }
  }

  public func fetchEpisodesByIDs(ids: [Int]) -> Observable<[RMEpisode]> {
    let request = RequestWithURL(url: endPoint.url(ids: ids))
      .request()

    return perform(request, type: [RMEpisodeDTO].self)
      .map { $0.map { $0.toDomain() } }
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
