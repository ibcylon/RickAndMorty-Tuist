//
//  CharacterService.swift
//  Network
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation

import RxSwift

import Core
import Networks
import CharacterInterface

public protocol CharacterService {
  func fetchAllCharacter(page: Int) -> Observable<RMCharacterInfo>
  func fetchSingleCharacterByID(id: Int) -> Observable<RMCharacter>
  func fetchCharactersByIDs(ids: [Int]) -> Observable<[RMCharacter]>
  func fetchCharactersByFilter(filter: RMCharacterFilter, page: Int) -> Observable<RMCharacterInfo>
}

public class DefaultCharacterService: CharacterService {
  private let client: HTTPClient
  private let endPoint: APIComponent

  public init(client: HTTPClient = URLSession.shared, endPoint: APIComponent) {
    self.client = client
    self.endPoint = endPoint
  }

  public func fetchAllCharacter(page: Int) -> Observable<RMCharacterInfo> {
    let request = RequestWithURL(url: endPoint.url(page: page)).request()

    return perform(request, type: RMCharacterInfoDTO.self)
      .map { $0.toDomain() }
  }

  public func fetchSingleCharacterByID(id: Int) -> Observable<RMCharacter> {
    let request = RequestWithURL(url: endPoint.url(id: id)).request()

    return perform(request, type: RMCharacterDTO.self)
      .map { $0.toDomain() }
  }

  public func fetchCharactersByIDs(ids: [Int]) -> Observable<[RMCharacter]> {
    let request = RequestWithURL(url: endPoint.url(ids: ids))
      .request()

    return perform(request, type: [RMCharacterDTO].self)
      .map { $0.map { $0.toDomain() } }
  }
  public func fetchCharactersByFilter(filter: RMCharacterFilter, page: Int) -> Observable<RMCharacterInfo> {
    let request = RequestWithURL(
      url: endPoint.url(
        page: page,
        filter: filter.toDictionary()))
      .request()
    return perform(request, type: RMCharacterInfoDTO.self)
      .map { $0.toDomain() }
  }
  // MARK: - private

  private func perform<T: Decodable>(_ request: URLRequest, type: T.Type) -> Observable<T> {
    RMLogger.dataLogger.debug("\(request)")
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
