//
//  URLCache+ImageCache.swift
//  Core
//
//  Created by Kanghos on 2023/12/22.
//

import Foundation

public extension URLCache {
  static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 512_000_000)
}
