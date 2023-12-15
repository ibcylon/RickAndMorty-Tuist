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

final class EpisodeListViewController: RMBaseViewController {

  private let mainView = EpisodeListView()
  var viewModel: EpisodeListViewModel!

  fileprivate var dataSource: DataSource!
  fileprivate let hasNextPageRelay = BehaviorRelay<Bool>(value: false)

  override func loadView() {
    self.view = mainView
  }

  override func makeUI() {
    self.title = "Episodes"
  }

  override func bindViewModel() {
    setupDataSource()

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

extension EpisodeListViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<EpisodeSection, RMEpisode>
  typealias Snapshot = NSDiffableDataSourceSnapshot<EpisodeSection, RMEpisode>

  enum EpisodeSection: Hashable {
    case main
  }
  // MARK: - Private
  private func setupDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<RMEpisodeCollectionViewCell, RMEpisode> { cell, indexPath, item in
      cell.configure(with: item)
    }

    let footerRegistration = UICollectionView.SupplementaryRegistration<RMFooterLoadingCollectionReusableView>(elementKind: UICollectionView.elementKindSectionFooter) { [weak self] supplementaryView, elementKind, indexPath in
      if self?.hasNextPageRelay.value == true {
        supplementaryView.startAnimating()
      } else {
        supplementaryView.stopAnimationg()
      }
    }

    dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    })

    dataSource.supplementaryViewProvider = { (view, kind, index) in
      return view.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
    }

    var initialSnapshot = Snapshot()
    initialSnapshot.appendSections([.main])
    initialSnapshot.appendItems([])
    dataSource.apply(initialSnapshot)
  }

  fileprivate func refreshDataSource(_ items: [RMEpisode]) {
    var snapshot = self.dataSource.snapshot()
    snapshot.appendItems(items)
    self.dataSource.apply(snapshot)
  }
}
