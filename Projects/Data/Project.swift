
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
  name: Feature.Data.rawValue,
  targets: [
    .feature(
      implementation: .Data,
      dependencies: [
        .domain
      ]
    ),
  ]
)
