//
//  Request.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/04.
//

import Foundation

public protocol Request {
  func request() -> URLRequest
}

public struct RequestWithURL: Request {
  private let url: URL

  public init(url: URL) {
    self.url = url
  }

  public func request() -> URLRequest {
    return URLRequest(url: url)
  }
}

public struct POSTRequest: Request {
  private let base: Request

  init(base: Request) {
    self.base = base
  }

  public func request() -> URLRequest {
    var request = base.request()
    request.httpMethod = "POST"
    return request
  }
}

public struct BearerRequest: Request {
  private let base: Request
  private let token: String

  init(base: Request, token: String) {
    self.base = base
    self.token = token
  }

  public func request() -> URLRequest {
    var request = base.request()
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    return request
  }
}

public struct RequestWithBody: Request {
  private let base: Request
  private let data: Data

  init(base: Request, data: Data) {
    self.base = base
    self.data = data
  }

  public func request() -> URLRequest {
    var request = base.request()
    request.httpBody = data

    return request
  }
}

public struct RequestWithQuery: Request {
  private let base: Request
  private let query: [URLQueryItem]

  init(base: Request, query: [URLQueryItem]) {
    self.base = base
    self.query = query
  }

  public func request() -> URLRequest {
    var request = base.request()

    request.url?.append(queryItems: query)
    return request
  }
}

public struct RequestWithPath: Request {
  private let base : Request
  private let path: [String]

  init(base: Request, path: [String]) {
    self.base = base
    self.path = path
  }

  public func request() -> URLRequest {
    var request = base.request()
    path.forEach { item in
      request.url?.append(path: item)
    }
    return request
  }
}
