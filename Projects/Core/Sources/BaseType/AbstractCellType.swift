//
//  AbstractCellType.swift
//  Core
//
//  Created by Kanghos on 2023/12/26.
//

import UIKit

public protocol AbstarctCellType {
  associatedtype I

  func bind(_ item: I)
}

public class BaseDiffableCell<I>: UICollectionViewCell, AbstarctCellType where I: Hashable {
  public typealias Item = I
  open func bind(_ items: Item) { }
}
