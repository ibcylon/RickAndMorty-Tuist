//
//  ImageRepositoryInterface.swift
//  Core
//
//  Created by Kanghos on 2023/12/11.
//

import Foundation

public protocol ImageRepositoryInterface {
  func loadImageData(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
