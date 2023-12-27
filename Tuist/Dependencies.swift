//
//  Dependencies.swift
//  Config
//
//  Created by Kanghos on 2023/11/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let spmDeps = SwiftPackageManagerDependencies(
  [
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.0")),
    .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMajor(from: "6.0.0")),
    .remote(url: "https://github.com/lorenzofiamingo/swiftui-cached-async-image.git", requirement: .upToNextMajor(from: "2.1.1")),
  ],
  productTypes: [:
//    External.SnapKit.rawValue: .staticFramework,
//    External.CachedAsyncImage.rawValue: .staticFramework,
  ]
)

public let dependencies = Dependencies(
  swiftPackageManager: spmDeps,
  platforms: [
    .iOS
  ]
)
