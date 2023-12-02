//
//  CharacterSearchViewController.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/03.
//

import UIKit
import SnapKit
import RxSwift

final class EpisodeDetailViewController: UIViewController {
  private var disposeBag = DisposeBag()

  var viewModel: EpisodeDetailViewModel!

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

    self.title = "EpisodeDetail"
    self.navigationController?.navigationBar.prefersLargeTitles = false
  }

  func bind() {

  }
}
