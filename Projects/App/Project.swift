//
//  Project.swift
//  Config
//
//  Created by Kanghos on 2023/11/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project(
  name: Feature.App.rawValue,
  targets: [
    .makeApp(
      name: "App",
      sources: "Sources/**",
      dependencies: [
        .feature,
        .module(implementation: .Data, pathName: .Data),
      ]
    )
  ]
)
