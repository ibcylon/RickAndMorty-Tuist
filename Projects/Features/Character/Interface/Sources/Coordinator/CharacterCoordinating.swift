

import Foundation
import Core

public protocol CharacterHomeFlow {
  func characterHomeFlow()
}

public protocol CharacterDetailFlow {
  func characterDetailFlow(_ item: RMCharacter)
}

public protocol CharacterCoordinatorDelegate: AnyObject {
  func detach(_ coordinator: Coordinator)
}

public protocol CharacterCoordinating: Coordinator, CharacterHomeFlow, CharacterDetailFlow {
  var delegate: CharacterCoordinatorDelegate? { get set }
}
