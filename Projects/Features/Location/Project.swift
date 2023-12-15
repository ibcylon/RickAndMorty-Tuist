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
    name: Feature.Location.rawValue,
    targets: [
        .feature(
            interface: .Location,
            dependencies: [
              .core
            ]
        ),
        .feature(
            implementation: .Location,
            dependencies: [
              .domain
            ]
        )
    ]
)
