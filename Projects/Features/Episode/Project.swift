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
    name: Feature.Episode.rawValue,
    targets: [
        .feature(
            interface: .Episode,
            dependencies: [
              .feature(interface: .Character)
            ]
        ),
        .feature(
            implementation: .Episode,
            dependencies: [
              .feature(interface: .Episode),
            ]
        )
    ]
)
