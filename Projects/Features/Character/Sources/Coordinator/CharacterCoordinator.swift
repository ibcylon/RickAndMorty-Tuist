
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

  // MARK: Private
  private func characterListFlow() {
    let viewModel = CharacterListViewModel(useCase: characterUseCase)

    viewModel.delegate = self
    let viewController = CharacterListViewController()
    viewController.viewModel = viewModel


    self.viewControllable.pushViewController(viewController, animated: true)
  }

  public func characterDetailFlow(_ item: RMCharacter) {

    let viewModel = CharacterDetailViewModel(useCase: characterUseCase, item: item)
    viewModel.delegate = self

    let viewController = CharacterDetailViewController()
    viewController.viewModel = viewModel

    self.viewControllable.pushViewController(viewController, animated: true)
  }
}

extension CharacterCoordinator: CharacterSearchDelegate {
  func presentItem(item: RMCharacter) {
    self.characterDetailFlow(item)
  }

  func logout() {
    self.viewControllable.setViewControllers([])
    self.delegate?.logout()
  }
}

extension CharacterCoordinator: CharacterDetailDelegate {
  func pop() {
    self.viewControllable.popViewController(animated: true)
  }
}
