//
//  APIComponent.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/04.
//

import Foundation

enum Constant {
  static let baseURLString: String = "https://rickandmortyapi.com/api"

}
public enum EndPoint: String {
  case character
  case location
  case episode
}

public struct APIComponent {
  private let endPoint: EndPoint

  public init(endPoint: EndPoint) {
    self.endPoint = endPoint
  }

  private var urlString: String {
    Constant.baseURLString + "/" + endPoint.rawValue
  }

  public var url: URL {
    URL(string: urlString)!
  }
  public func url(page: Int) -> URL {
    URL(string: urlString + "?page=\(page)")!
  }

  public func url(id: Int) -> URL {
    URL(string: urlString + "/\(id)")!
  }

  public func url(ids: [Int]) -> URL {
    URL(string: urlString + "/\(ids)")!
  }
}
