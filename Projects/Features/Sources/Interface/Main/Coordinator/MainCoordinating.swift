//
//  MainCoordinating.swift
//  Feature
//
//  Created by Kanghos on 2023/12/01.
//

import Foundation
import Core

protocol MainCoordinatingDelegate: AnyObject {
  func detachMain(_ coordinator: Coordinator)
}
protocol MainCoordinating: Coordinator {
  var delegate: MainCoordinatingDelegate? { get set }
  func attachTab()
}
