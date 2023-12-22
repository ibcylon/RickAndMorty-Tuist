//
//  UIBarButtonItem+Util.swift
//  Core
//
//  Created by Kanghos on 2023/12/18.
//

import UIKit

public extension UIBarButtonItem {
  enum ButtonType: String {
    case back = "chevron.backward"
    case close = "xmark"
    case search = "magnifyingglass"
  }

  static func makeBackButton() -> UIBarButtonItem {
    makeImageBarButton(named: "chevron.backward")
  }
  static func makeCloseButton() -> UIBarButtonItem {
    makeImageBarButton(named: "xmark")
  }
  static func makeSearchButton() -> UIBarButtonItem {
    makeImageBarButton(named: "magnifyingglass")
  }

  static func makeImageBarButton(type: ButtonType) -> UIBarButtonItem {
    makeImageBarButton(named: type.rawValue)
  }

  private static func makeImageBarButton(named: String) -> UIBarButtonItem {
    UIBarButtonItem(
      image: UIImage(systemName: named),
      style: .plain,
      target: nil,
      action: nil
    )
  }
}

