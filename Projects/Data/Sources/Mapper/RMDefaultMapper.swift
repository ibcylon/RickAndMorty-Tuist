//
//  RMDefaultMapper.swift
//  Data
//
//  Created by Kanghos on 2023/12/10.
//

import Foundation
import Networks

struct RMDefaultMapper<T: Decodable> {
  static func map(data: Data, response: HTTPURLResponse, type: T.Type) throws -> T {
    if response.statusCode == 200 {
      do {
        let decoded = try JSONDecoder().decode(type.self, from: data)
        return decoded
      } catch {
        throw RemoteError.decode
      }
    } else {
      throw RemoteError.invalidResponse(response.statusCode)
    }
  }
}

