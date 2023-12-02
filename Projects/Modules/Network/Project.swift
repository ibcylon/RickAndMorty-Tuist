//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/11/26.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project.dynamicFramework(
  name: Feature.Network.rawValue,
  dependencies: [
    .domain
  ]
)
