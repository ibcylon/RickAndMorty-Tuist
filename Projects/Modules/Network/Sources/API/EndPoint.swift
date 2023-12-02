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

  var url: URL {
    URL(string: urlString)!
  }
}
