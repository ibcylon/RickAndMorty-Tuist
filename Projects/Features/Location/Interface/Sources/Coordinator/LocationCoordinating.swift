

import Foundation
import Core

public protocol LocationHomeFlow { 
  func locationHomeFlow()
}

public protocol LocationDetailFlow {
  func locationDetailFlow(_ item: RMLocation)
}

public protocol LocationCoordinatorDelegate: AnyObject {
  func detach(_ coordinator: Coordinator)
}

public protocol LocationCoordinating: Coordinator, LocationHomeFlow, LocationDetailFlow {
  var delegate: LocationCoordinatorDelegate? { get set }
}
