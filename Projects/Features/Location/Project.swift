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
                .feature(interface: .Character),
            ]
        ),
        .feature(
            implementation: .Location,
            dependencies: [
                .feature(interface: .Location),
            ]
        )
    ]
)
