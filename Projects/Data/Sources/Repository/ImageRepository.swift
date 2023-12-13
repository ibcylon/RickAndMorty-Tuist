//
//  ImageRepository.swift
//  Data
//
//  Created by Kanghos on 2023/12/11.
//

import Foundation
import Core

public final class ImageRepository {
  private let imageService: ImageService

  public init(imageService: ImageService) {
    self.imageService = imageService
  }
}

extension ImageRepository: ImageRepositoryInterface {
  public func loadImageData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
    return imageService.loadImageData(url, completion: completion)
  }
}
