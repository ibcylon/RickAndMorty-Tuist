//
//  MainCoordinating.swift
//  Feature
//
//  Created by Kanghos on 2023/12/01.
//

import Foundation
import Core

protocol RegisterCoordinatingDelegate: AnyObject {
  func detachRegister(_ coordinator: Coordinator)
}
protocol RegisterCoordinating: Coordinator {
  var delegate: RegisterCoordinatingDelegate? { get set }
  func attachRegister()
}
