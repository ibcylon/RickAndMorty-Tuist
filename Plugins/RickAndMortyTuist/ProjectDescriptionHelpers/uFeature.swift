//
//  uFeature.swift
//  MyPlugin
//
//  Created by Kanghos on 2023/11/19.
//

import Foundation
import ProjectDescription

public enum Feature: String {
  case Core = "Core"
  case Character = "Character"
  case Location = "Location"
  case Episode = "Episode"
  case App = "App"
  case Data = "Data"
  case Domain = "Domain"
  case BaseTest = "BaseTest"

  case Networks
  case ThirdPartyLibs
  case DesignSystem
}

public enum ModulePath {
  case App
  case Core
  case Data
  case Domain
  case Features
  case Modules(ModuleName)

  public enum ModuleName: String {
    case Networks
    case ThirdPartyLibs
    case DesignSystem
    case BaseTest
  }

  var name: String {
    switch self {
    case .App:
      return "App"
    case .Core:
      return "Core"
    case .Domain:
      return "Domain"
    case .Data:
      return "Data"
    case .Features:
      return "Features"
    case .Modules(let moduleName):
      return "Modules/\(moduleName.rawValue)"
    }
  }
}

public enum External: String {
  case RxSwift
  case RxCocoa
  case SnapKit
  case CachedAsyncImage
  case RxTest
  case RxBlocking
  case RxRelay
}

public extension TargetDependency {

  // MARK: Feature
  static var feature: Self {
    .project(target: "Feature", path: .relativeToRoot("Projects/Features"))
  }

  private static func feature(target: String, featureName: String) -> ProjectDescription.TargetDependency {
    .project(target: target, path: .relativeToRoot("Projects/Features/" + featureName))
  }

  private static func feature(interface moduleName: String) -> ProjectDescription.TargetDependency {
    .feature(target: moduleName + "Interface", featureName: moduleName)
  }

  private static func feature(implementation moduleName: String) -> ProjectDescription.TargetDependency {
    .feature(target: moduleName, featureName: moduleName)
  }

  static func feature(interface moduleName: Feature) -> ProjectDescription.TargetDependency {
    .feature(interface: moduleName.rawValue)
  }

  static func feature(implementation moduleName: Feature) -> ProjectDescription.TargetDependency {
    .feature(implementation: moduleName.rawValue)
  }

  static func feature(testing moduleName: Feature) -> TargetDependency {
    .feature(target: moduleName.rawValue + "Testing", featureName: moduleName.rawValue)
  }

  // MARK: Module

  private static func module(target: String, pathName: String) -> TargetDependency {
    .project(target: target, path: .relativeToRoot("Projects/\(pathName)/"))
  }
  static func module(implementation moduleName: Feature, pathName: ModulePath) -> TargetDependency {
    .module(target: moduleName.rawValue, pathName: pathName.name)
  }

  static func external(_ module: External) -> ProjectDescription.TargetDependency {
    .external(name: module.rawValue)
  }

  static var core: ProjectDescription.TargetDependency {
    .module(implementation: .Core, pathName: .Core)
  }

  static var data: ProjectDescription.TargetDependency {
    .module(implementation: .Data, pathName: .Data)
  }
  static var domain: TargetDependency {
    .module(implementation: .Domain, pathName: .Domain)
  }
  static var baseTest: TargetDependency {
    .module(implementation: .BaseTest, pathName: .Modules(.BaseTest))
  }
}
