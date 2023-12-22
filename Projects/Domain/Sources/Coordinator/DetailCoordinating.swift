//
//  CharacterDetailCoordinating.swift
//  Domain
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation
//
import Core
import CharacterInterface
import LocationInterface
import EpisodeInterface

public protocol BottomSheetFlow {
  func chooseBottomSheet(_ filter: Filter.Item, listener: BottomSheetListener)
  func typingBottomSheet(_ filter: Filter.Item, listener: BottomSheetListener)
}

public protocol BottomSheetListener: AnyObject {
  func setFilter(item: Filter.Item)
}

public protocol DetailCoordinatorDelegate: AnyObject {
  func detach(coordinator: Coordinator)
}

public protocol DetailCoordinating: Coordinator, CharacterDetailFlow, EpisodeDetailFlow, LocationDetailFlow {
  var delegate: DetailCoordinatorDelegate? { get set }
}
