//
//  RMGender.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/26.
//

import Foundation

public enum RMGender: String, Codable, CaseIterable {
  case female = "Female"
  case male = "Male"
  case genderless = "Genderless"
  case unknown = "unknown"
}
