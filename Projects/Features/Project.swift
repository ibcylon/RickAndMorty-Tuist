//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/11/26.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project(
  name: "Features Layer",
  targets: [
    .feature(
      dependencies: [
        .feature(implementation: .Character),
        .feature(implementation: .Location),
        .feature(implementation: .Episode),
      ]
    )
  ]
)
