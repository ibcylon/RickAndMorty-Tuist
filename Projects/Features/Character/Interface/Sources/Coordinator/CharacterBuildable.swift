import UIKit
import Core

public protocol CharacterBuildable {
  func build(rootViewControllable: ViewControllable) -> CharacterCoordinating
}
