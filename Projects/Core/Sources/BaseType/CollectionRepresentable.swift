//
//  CollectionRepresentable.swift
//  Core
//
//  Created by Kanghos on 2023/12/26.
//

import UIKit

public protocol CollectionRepresentable: UIView {
  var progressView: UIActivityIndicatorView { get }
  var collectionView: UICollectionView { get }
}
