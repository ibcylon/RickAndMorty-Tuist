
import UIKit
import Core
import CharacterInterface

public final class CharacterBuilder: CharacterBuildable {

  private let navigationController: UINavigationController

  public init() {
    self.navigationController = UINavigationController()
  }

  public func build() -> CharacterCoordinating {
    return CharacterCoordinator(navigationController: self.navigationController)
  }
}
