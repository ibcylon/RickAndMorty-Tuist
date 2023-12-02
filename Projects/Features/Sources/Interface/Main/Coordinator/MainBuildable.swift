//
//  MainBuildable.swift
//  Feature
//
//  Created by Kanghos on 2023/12/01.
//

import UIKit

protocol MainBuildable {
  func build(navigationController: UINavigationController) -> MainCoordinating
}
