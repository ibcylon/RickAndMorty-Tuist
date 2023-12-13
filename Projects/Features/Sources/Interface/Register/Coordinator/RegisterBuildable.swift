//
//  MainBuildable.swift
//  Feature
//
//  Created by Kanghos on 2023/12/01.
//

import UIKit
import Core

protocol RegisterBuildable {
  func build(rootViewControllable: ViewControllable) -> RegisterCoordinating
}
