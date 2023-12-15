//
//  UICollectionViewLayout+Util.swift
//  Core
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit

public extension UICollectionViewLayout {
  static func createPagingListLayout() -> UICollectionViewLayout {
    let layout = createListLayout()
    layout.footerReferenceSize = CGSize(width: layout.collectionViewContentSize.width, height: 100)

    return layout
  }

  static func createListLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    let bound = UIScreen.main.bounds
    let width = bound.width - 14 * 2
    let height = width * (108 / 358)

    layout.itemSize = CGSize(width: width, height: height)
    layout.minimumLineSpacing = 8
    layout.scrollDirection = .vertical

    return layout
  }

  static func createPagingGridLayout(padding: CGFloat = 15.0, ratio: CGFloat = 1.5) -> UICollectionViewLayout {
    let layout = createGridLayout(padding: padding, ratio: ratio)
    layout.footerReferenceSize = .init(width: layout.collectionViewContentSize.width, height: 100)
    return layout
  }

  static func createGridLayout(padding: CGFloat = 15.0, ratio: CGFloat = 1.5) -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    let bound = UIScreen.main.bounds
    let width = (bound.width - padding * 2) / 2
    let height = width * ratio

    layout.itemSize = CGSize(width: width, height: height)
    layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)

    return layout
  }
}
