import UIKit
import Core

public protocol LocationBuildable {
  func build(rootViewControllable: ViewControllable) -> LocationCoordinating
}
