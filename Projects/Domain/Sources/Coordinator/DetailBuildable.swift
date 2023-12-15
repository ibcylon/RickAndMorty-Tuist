import Core

public protocol DetailBuildable {
  func build(rootViewControllable: ViewControllable) -> DetailCoordinating
}
