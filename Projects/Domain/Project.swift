//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/12/14.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project(
  name: Feature.Domain.rawValue,
  targets: [
    .feature(
      implementation: .Domain,
      productType: .framework,
      dependencies: [
        .feature(interface: .Character),
        .feature(interface: .Location),
        .feature(interface: .Episode)
      ]
    ),
  ]
)
