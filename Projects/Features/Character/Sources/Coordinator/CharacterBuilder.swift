
import UIKit
import Core
import CharacterInterface

public final class CharacterBuilder: CharacterBuildable {
  public init() { }
  public func build(rootViewControllable: ViewControllable) -> CharacterCoordinating {
    CharacterCoordinator(rootViewController: rootViewControllable)
  }
}
