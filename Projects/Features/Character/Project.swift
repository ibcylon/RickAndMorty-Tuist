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
    name: Feature.Character.rawValue,
    targets: [
        .feature(
            interface: .Character,
            dependencies: [
              .core,
            ]
        ),
        .feature(
            implementation: .Character,
            dependencies: [
              .feature(interface: .Character),
            ]
        )
    ]
)
