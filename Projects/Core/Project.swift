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
  name: Feature.Core.rawValue,
  targets: [
    .feature(
      implementation: .Core,
      productType: .framework,
      dependencies: [
        .module(implementation: .ThirdPartyLibs, pathName: .Modules(.ThirdPartyLibs)),
        .module(implementation: .Networks, pathName: .Modules(.Networks)),
      ],
      resources:  [.glob(pattern: .relativeToRoot("Projects/App/Resources/**"))]
    )
  ]
)
