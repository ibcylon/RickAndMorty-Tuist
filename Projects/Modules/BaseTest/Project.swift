//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/12/27.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project.dynamicFramework(
  name: Feature.BaseTest.rawValue,
  dependencies: [
    .external(.RxSwift),
    .external(.RxRelay),
    .external(.RxCocoa),
    .external(.RxBlocking),
    .external(.RxTest),
    .sdk(name: "XCTest", type: .framework, status: .required)
  ]
)
