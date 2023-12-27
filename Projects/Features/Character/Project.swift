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
              .domain
            ]
        ),
        .feature(
          demo: .Character,
          dependencies: [
            .feature(implementation: .Character),
            .feature(testing: .Character),
            .data
          ]
        ),
        .feature(
          unitTest: .Character,
          dependencies: [
            .baseTest,
            .feature(testing: .Character),
            .feature(implementation: .Character)
          ]
        ),

        .feature(
          testing: .Character,
          dependencies: [
            .feature(interface: .Character)
          ]
        )
    ]
)
