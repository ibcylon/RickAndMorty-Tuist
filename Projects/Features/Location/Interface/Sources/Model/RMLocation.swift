//
//  RMLocation.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

// MARK: - RMLocation
public struct RMLocation: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
