
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
  name: Feature.Domain.rawValue,
  targets: [
    .feature(
      implementation: .Domain,
      dependencies: [
        .feature(interface: .Episode),
        .feature(interface: .Character),
        .feature(interface: .Location),
      ]
    ),
  ]
)
