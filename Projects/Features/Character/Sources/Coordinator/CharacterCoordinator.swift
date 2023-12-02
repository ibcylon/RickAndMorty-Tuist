
import UIKit
import Core
import RxSwift
import CharacterInterface

public protocol CharacterCoordinatorDelegate: AnyObject {
  func logout()
}

public final class CharacterCoordinator: BaseCoordinator, CharacterCoordinating {

  public var delegate: CharacterCoordinatorDelegate?

  @Injected public var characterUseCase: FetchCharacterUseCaseInterface

  public override func start() {
    characterListFlow()
  }

  public func characterDetailFlow() {

  }

  // MARK: Private
  private func characterListFlow() {
    let viewModel = CharacterListViewModel(useCase: characterUseCase)

    viewModel.delegate = self

    let viewController = CharacterListViewController()
    viewController.viewModel = viewModel

    self.navigationController.pushViewController(viewController, animated: true)
  }

  public func characterDetailFlow(item: RMCharacter) {

    let viewModel = CharacterDetailViewModel(useCase: characterUseCase, item: item)
    viewModel.delegate = self

    let viewController = CharacterDetailViewController()
    viewController.viewModel = viewModel

    self.navigationController.pushViewController(viewController, animated: true)
  }
}

extension CharacterCoordinator: CharacterSearchDelegate {
  func presentItem(item: RMCharacter) {
    self.characterDetailFlow(item: item)
  }

  func logout() {
    self.navigationController.viewControllers = []
    self.delegate?.logout()
  }
}

extension CharacterCoordinator: CharacterDetailDelegate {
  func pop() {
    self.navigationController.popViewController(animated: true)
  }
}
