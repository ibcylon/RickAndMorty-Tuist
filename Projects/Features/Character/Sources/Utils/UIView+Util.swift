//
//  UIView+Util.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/10.
//

import UIKit

extension UIView {
  func addSubViews(_ views: UIView...) {
    views.forEach {
      self.addSubview($0)
    }
  }
}
