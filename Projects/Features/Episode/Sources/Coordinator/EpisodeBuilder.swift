import UIKit
import Core
import EpisodeInterface

public final class EpisodeBuilder: EpisodeBuildable {

  private let navigationController: UINavigationController

  public init() {
    self.navigationController = UINavigationController()
  }

  public func build() -> EpisodeCoordinating {
    return EpisodeCoordinator(navigationController: self.navigationController)
  }
}
