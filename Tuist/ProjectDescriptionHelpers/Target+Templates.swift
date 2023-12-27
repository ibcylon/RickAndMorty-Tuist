//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/11/26.
//

import ProjectDescription
import MyPlugin

private let rootPackagesName = "com.rickandmorty."

private let basicDeployment: DeploymentTarget = .iOS(targetVersion: "16.2", devices: .iphone)

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
      deploymentTarget: basicDeployment,
      infoPlist: .extendingDefault(with: infoPlistExtension),
      sources: sources,
      resources:  [.glob(pattern: .relativeToRoot("Projects/App/Resources/**"))],
      dependencies: dependencies
    )
  }

  static func makeFramework(
    name: String,
    productType: Product,
    sources: ProjectDescription.SourceFilesList,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    Target(
      name: name,
      platform: .iOS,
      product: productType,
      bundleId: makeBundleID(with: name + ".framework"),
      deploymentTarget: basicDeployment,
      sources: sources,
      resources: resources,
      dependencies: dependencies
    )
  }

  private static func feature(
    implementation featureName: String,
    productType: Product,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    .makeFramework(
      name: featureName,
      productType: productType,
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
      productType: .framework,
      sources: [ "Interface/Sources/**" ],
      dependencies: dependencies,
      resources: resources
    )
  }

  static func feature(
    implementation featureName: Feature,
    productType: Product = .staticLibrary,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    .feature(
      implementation: featureName.rawValue,
      productType: productType,
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
      productType: .staticLibrary,
      sources: "Sources/**",
      dependencies: dependencies
    )
  }

}
