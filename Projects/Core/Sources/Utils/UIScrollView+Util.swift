//
//  UIScrollView+Util.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/09.
//

import UIKit

public extension UIScrollView {
  var needMorePage: Bool {
    let offset = self.contentOffset.y
    let totalContentHeight = self.contentSize.height
    let totalScrollViewFixedHeight = self.frame.size.height

    if offset >= (totalContentHeight - totalScrollViewFixedHeight) - 10 {
      return true
    }
    return false
  }
}
