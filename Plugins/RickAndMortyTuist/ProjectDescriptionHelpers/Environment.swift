//
//  Environment.swift
//  MyPlugin
//
//  Created by Kanghos on 2023/12/27.
//

import Foundation
import ProjectDescription

public enum EnvironmentHelpers {
  public static let appName: String = "RickAndMortyTuist"
  public static let rootPackagesName = "com.\(appName)."
  public static let basicDeployment: DeploymentTarget = .iOS(targetVersion: "16.2", devices: .iphone)
  public static let globalResourcePath: ResourceFileElements = [.glob(pattern: .relativeToRoot("Projects/App/Resources/**"))]

  public static func makeBundleID(with addition: String) -> String {
    (rootPackagesName + addition).lowercased()
  }
}
