//
//  CharacterSearchViewController.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/03.
//

import UIKit
import SnapKit
import RxSwift

final class CharacterListViewController: UIViewController {
  private var disposeBag = DisposeBag()

  var viewModel: CharacterListViewModel!

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

    self.title = "Characters"
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }

  func bind() {

  }
}
