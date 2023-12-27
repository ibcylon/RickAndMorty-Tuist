//
//  Test+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/12/24.
//

import Foundation
import ProjectDescription
import MyPlugin

public extension Target {
  static func feature(
    unitTest featureName: Feature,
    dependencies: [TargetDependency] = []
  ) -> Target {
    makeFramework(
      name: featureName.rawValue + "UnitTest",
      productType: .unitTests,
      sources: ["Test/Sources/**"],
      dependencies: dependencies
    )
  }

  static func feature(
    testing featureName: Feature,
    dependencies: [TargetDependency]
  ) -> Target {
    makeFramework(
      name: featureName.rawValue + "Testing",
      productType: .staticLibrary,
      sources: ["Testing/Sources/**"],
      dependencies: dependencies
    )
  }
}

