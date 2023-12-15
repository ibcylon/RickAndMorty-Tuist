
import UIKit
import Core
import Domain

public final class CharacterBuilder: CharacterBuildable {
  private let detailBuildable: DetailBuildable

  public init(detailBuildable: DetailBuildable) {
    self.detailBuildable = detailBuildable
  }
  public func build(rootViewControllable: ViewControllable) -> CharacterCoordinating {
    CharacterCoordinator(
      rootViewControllable: rootViewControllable,
      detailBuildable: detailBuildable
    )
  }
}

