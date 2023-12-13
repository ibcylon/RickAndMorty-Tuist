//
//  CharacterSearchViewController.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Core

final class CharacterDetailViewController: RMBaseViewController {

  private let mainView = RMCharacterDetailView()

  var viewModel: CharacterDetailViewModel!

  var button = UIButton()
  override func loadView() {
    self.view = mainView
  }


  override func makeUI() {
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.prefersLargeTitles = false
  }

  override func bindViewModel() {
    let input = CharacterDetailViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }
        .asDriver(onErrorJustReturn: ()),
      backButtonTap: self.button.rx.tap.asDriver()
    )

    let output = viewModel.transform(input: input)

    output.item
      .drive(onNext: { [weak self] item in
        self?.mainView.bind(item: item)
        self?.title = item.name
      })
      .disposed(by: disposeBag)
    output.route
      .drive()
      .disposed(by: disposeBag)
  }
}
