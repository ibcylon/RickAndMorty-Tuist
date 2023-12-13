

import Foundation
import Core

public protocol LocationCoordinating: Coordinator {
  func locationHomeFlow()
  func locationDetailFlow(_ item: RMLocation)
}
