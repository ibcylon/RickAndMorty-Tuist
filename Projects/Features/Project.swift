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
    name: "Feature",
    targets: [
      .feature(
        dependencies: [
          .feature(implementation: .Character),
          .feature(implementation: .Location),
          .module(implementation: .Data, pathName: .Data)
        ]
      )
    ]
)
