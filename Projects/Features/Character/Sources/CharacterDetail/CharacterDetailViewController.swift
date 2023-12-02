//
//  CharacterSearchViewController.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/03.
//

import UIKit
import SnapKit
import RxSwift

final class CharacterDetailViewController: UIViewController {
  private var disposeBag = DisposeBag()

  var viewModel: CharacterDetailViewModel!

  deinit { }

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpViews()
    bind()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  private func setUpViews() {
    self.view.backgroundColor = .white

    self.title = "CharactersDetail"
    self.navigationController?.navigationBar.prefersLargeTitles = false
  }

  func bind() {

  }
}
