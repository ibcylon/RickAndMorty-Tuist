//
//  RMDataCacheLoader.swift
//  Data
//
//  Created by Kanghos on 2023/12/21.
//

import Foundation

import Core
import Networks

final class RMCacheManager {
  private var cacheDictionary: [EndPoint: NSCache<NSString, NSData>] = [:]

  public init() {
    self.client = URLSession.shared
  }

  private let client: HTTPClient
  private var fileManager: FileManager {
    FileManager.default
  }
  private var cachePath: URL {
    URL.cachesDirectory 
  }

  private func setUpCache() {
      EndPoint.allCases
      .forEach { endPoint in
        cacheDictionary[endPoint] = NSCache<NSString, NSData>()
      }
  }

  private func setCache(endPoint: EndPoint, url: URL?, data: Data) {
    guard
      let keyString = url?.absoluteString,
      let cache = cacheDictionary[endPoint]
    else {
      return
    }
    let key = keyString as NSString
    cache.setObject(data as NSData, forKey: key)
  }

  private func cacheResponse(endPoint: EndPoint, url: URL?) -> Data? {
    guard
      let keyString = url?.absoluteString,
      let cache = cacheDictionary[endPoint]
    else {
      return nil
    }
    let key = keyString as NSString

    return cache.object(forKey: key) as? Data
  }

  private func fetchFromDisk(_ url: URL) -> Data? {
    let imageName = url.lastPathComponent
    let endPoint = cachePath.appending(path: imageName, directoryHint: .notDirectory)

    guard fileManager.fileExists(atPath: endPoint.path()),
          let imageData = try? Data(contentsOf: endPoint)
    else {
      return nil
    }
    return imageData
  }

  private func cacheDisk(key: URL, data: Data) {
    let imageName = key.lastPathComponent
    let endPoint = cachePath.appending(path: imageName, directoryHint: .notDirectory)

    fileManager.createFile(atPath: endPoint.path(), contents: data)
  }
}
