//
//  EpisodeListViewController.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

import EpisodeInterface
import Core

final class EpisodeListViewController: BaseDiffableDataSourceViewController<RMEpisodeCollectionViewCell, RMEpisodeCollectionViewCell.Item> {

  private let viewModel: EpisodeListViewModel

  init(viewModel: EpisodeListViewModel) {
    self.viewModel = viewModel
    let mainView = EpisodeListView()
    super.init(mainView: mainView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func makeUI() {
    self.title = "Episodes"
  }

  override func bindViewModel() {
    super.bindViewModel()

    let pagingTrigger = self.mainView.collectionView.rx.didScroll
      .filter { self.mainView.collectionView.needMorePage }
      .asDriver(onErrorDriveWith: .empty())

    let input = EpisodeListViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }.asDriver(onErrorJustReturn: ()),
      buttonTap: self.mainView.collectionView.rx.itemSelected.asDriver(),
      paging: pagingTrigger
    )

    let output = viewModel.transform(input: input)

    output.items
      .drive(with: self, onNext: { owner, items in
        UIView.animate(withDuration: 0.4) {
          owner.mainView.collectionView.isHidden = false
          owner.mainView.collectionView.alpha = 1
        }
        owner.mainView.progressView.stopAnimating()
        owner.refreshDataSource(items)
      })
      .disposed(by: disposeBag)

    output.route
    .disposed(by: disposeBag)

    output.hasNextPage
      .drive(hasNextPageRelay)
      .disposed(by: disposeBag)
  }
}
