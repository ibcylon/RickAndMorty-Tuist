import ProjectDescription
import MyPlugin

private let basicDeployment: DeploymentTarget = .iOS(targetVersion: "16.2", devices: .iphone)
public extension Project {
   static func dynamicFramework(
    name: String,
    dependencies: [TargetDependency]
  ) -> Project {
    let target = Target(
        name: name,
        platform: .iOS,
        product: .framework,
        bundleId: "com.rickandmorty.\(name)",
        deploymentTarget: basicDeployment,
        infoPlist: .default,
        sources: ["Sources/**/*.swift"],
        resources:  [.glob(pattern: .relativeToRoot("Projects/App/Resources/**"))],
        dependencies: dependencies
    )

    return Project(
      name: name,
      targets: [target]
    )
  }

  static func library(
   name: String,
   dependencies: [TargetDependency],
   product: Product = .staticLibrary
 ) -> Project {
   let target = Target(
       name: name,
       platform: .iOS,
       product: product,
       bundleId: "com.rickandmorty.\(name)",
       deploymentTarget: basicDeployment,
       infoPlist: .default,
       sources: ["Sources/**/*.swift"],
       resources:  [.glob(pattern: .relativeToRoot("Projects/App/Resources/**"))],
       dependencies: dependencies
   )

   return Project(
     name: name,
     targets: [target]
   )
 }

}
