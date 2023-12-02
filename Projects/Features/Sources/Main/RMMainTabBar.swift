//
//  RMTabBarController.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/03.
//

import UIKit

final class RMTabBarController: UITabBarController, MainViewControllable {
  var uiViewController: UIViewController { self }
  
  deinit {

  }
  func setViewController(_ viewControllers: [UIViewController]) {
    super.setViewControllers(viewControllers, animated: false)
  }
  enum Feature: String {
    case episode
    case character
    case location

    var image: String {
      switch self {
      case .episode:
        return "play.circle"
      case .character:
        return "person.circle"
      case .location:
        return "map"
      }
    }
  }
}
