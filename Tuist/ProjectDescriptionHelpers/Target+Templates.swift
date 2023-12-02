//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/11/26.
//

import ProjectDescription
import MyPlugin

private let rootPackagesName = "com.exampleproject."

private func makeBundleID(with addition: String) -> String {
  (rootPackagesName + addition).lowercased()
}

public extension Target {
  static func makeApp(
    name: String,
    sources: ProjectDescription.SourceFilesList,
    dependencies: [ProjectDescription.TargetDependency]
  ) -> Target {
    Target(
      name: name,
      platform: .iOS,
      product: .app,
      bundleId: makeBundleID(with: "app"),
      deploymentTarget: .iOS(targetVersion: "16.1", devices: .iphone),
      infoPlist: .extendingDefault(with: infoPlistExtension),
      sources: sources,
      resources:  [.glob(pattern: .relativeToRoot("Projects/App/Resources/**"))],
      dependencies: dependencies
    )
  }

  static func makeFramework(
    name: String,
    sources: ProjectDescription.SourceFilesList,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    Target(
      name: name,
      platform: .iOS,
      product: defaultPackageType,
      bundleId: makeBundleID(with: name + ".framework"),
      deploymentTarget: .iOS(targetVersion: "16.1", devices: .iphone),
      sources: sources,
      resources: resources,
      dependencies: dependencies
    )
  }

  private static func feature(
    implementation featureName: String,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    .makeFramework(
      name: featureName,
      sources: [ "Sources/**" ],
      dependencies: dependencies,
      resources: resources
    )
  }

  private static func feature(
    interface featureName: String,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    .makeFramework(
      name: featureName + "Interface",
      sources: [ "Interface/Sources/**" ],
      dependencies: dependencies,
      resources: resources
    )
  }

  static func feature(
    implementation featureName: Feature,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    .feature(
      implementation: featureName.rawValue,
      dependencies: dependencies,
      resources: resources
    )
  }

  static func feature(
    interface featureName: Feature,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    .feature(
      interface: featureName.rawValue,
      dependencies: dependencies,
      resources: resources
    )
  }
  static func feature(
    dependencies: [ProjectDescription.TargetDependency] = []
  ) -> Target {
    .makeFramework(
      name: "Feature",
      sources: "Sources/**",
      dependencies: dependencies
    )
  }

}
