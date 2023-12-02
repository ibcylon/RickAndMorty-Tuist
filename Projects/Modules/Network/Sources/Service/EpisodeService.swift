//
//  CharacterService.swift
//  Network
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation
import RxSwift
import EpisodeInterface

public protocol EpisodeService {
  func fetchAllEpisode(page: Int) -> Observable<RMEpisodeInfo>
}

public class DefaultEpisodeService: EpisodeService {
  private let client: HTTPClient
  private let endPoint: APIComponent

  public init(client: HTTPClient = URLSession.shared, endPoint: APIComponent) {
    self.client = client
    self.endPoint = endPoint
  }

  public func fetchAllEpisode(page: Int) -> Observable<RMEpisodeInfo> {
    let request = RequestWithURL(url: endPoint.url).request()

    return performInfoList(request)
  }

  // MARK: - private

  private func performInfoList(_ request: URLRequest) -> Observable<RMEpisodeInfo> {
    return .create { [weak self] observer in
      self?.client.perform(request) { result in
        switch result {
        case .success(let response):
          do {
            let info = try RMDefaultMapper.map(type: RMEpisodeInfo.self, data: response.0, response: response.1)
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
