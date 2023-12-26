//
//  CharacterSearchViewController.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/03.
//

import UIKit
import SwiftUI

import SnapKit
import RxSwift
import RxCocoa
import CachedAsyncImage

import CharacterInterface
import Core

final class CharacterListViewController: CharacterDataSourceViewController {

  private let viewModel: CharacterListViewModel

  public init(viewModel: CharacterListViewModel) {
    self.viewModel = viewModel
    super.init(mainView: CharacterListView())
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func makeUI() {
    self.title = "Characters"
  }

  private let searchButton = UIBarButtonItem.makeSearchButton()
  private let logoutButton = UIBarButtonItem.makeImageBarButton(type: .logout)

  override func navigationSetting() {
    super.navigationSetting()
    navigationItem.rightBarButtonItem = searchButton
    navigationItem.rightBarButtonItems?.append(logoutButton)
  }

  override func bindViewModel() {
    super.bindViewModel()

    let input = CharacterListViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }.asDriver(onErrorJustReturn: ()),
      itemSelected: self.mainView.collectionView.rx.itemSelected.asDriver(),
      search:
        self.searchButton.rx.tap.asDriver(),
      logout:
        self.logoutButton.rx.tap.asDriver(),
      paging: pagingTrigger
    )
//
    let output = viewModel.transform(input: input)

    output.characterArray
      .drive(with: self, onNext: { owner, items in
        UIView.animate(withDuration: 0.4) {
          owner.mainView.collectionView.isHidden = false
          owner.mainView.collectionView.alpha = 1
        }
        owner.mainView.progressView.stopAnimating()
        owner.refreshDataSource(items)
      })
      .disposed(by: disposeBag)

    output.hasNextPage
      .drive(hasNextPageRelay)
      .disposed(by: disposeBag)
  }
}
