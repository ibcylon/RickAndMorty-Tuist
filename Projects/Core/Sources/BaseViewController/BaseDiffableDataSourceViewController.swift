//
//  BaseDiffableViewController.swift
//  Core
//
//  Created by Kanghos on 2023/12/26.
//

import UIKit
import SwiftUI

import SnapKit
import RxSwift
import RxCocoa
import CachedAsyncImage

open class BaseDiffableDataSourceViewController<CellType, ModelType>: RMBaseViewController where CellType: BaseDiffableCell<ModelType>, ModelType: Hashable {

  public let mainView: CollectionRepresentable

  public init(mainView: CollectionRepresentable) {
    self.mainView = mainView
    super.init()
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  fileprivate var dataSource: DataSource!
  public let hasNextPageRelay = BehaviorRelay<Bool>(value: false)

  public override func loadView() {
    self.view = mainView
  }

  open override func bindViewModel() {
    setupDataSource()
  }
}

extension BaseDiffableDataSourceViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<Section, ModelType>
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ModelType>

  enum Section: Hashable {
    case main
  }

  private var hasPage: Bool {
    self.hasNextPageRelay.value
  }

  public var pagingTrigger: Driver<Void> {
    self.mainView.collectionView.rx.didEndDecelerating
      .asDriver()
      .filter { [weak self] in
        guard let self = self else { return false }
        RMLogger.dataLogger.info("pagingTrigger")
        return self.mainView.collectionView.needMorePage
      }
  }

  // MARK: - Private
  private func setupDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<CellType, ModelType> { cell, indexPath, item in
      cell.bind(item)
    }

    let footerRegistration = UICollectionView.SupplementaryRegistration<RMFooterLoadingCollectionReusableView>(elementKind: UICollectionView.elementKindSectionFooter) { [weak self] supplementaryView, elementKind, indexPath in
      if self?.hasPage == true {
        supplementaryView.startAnimating()
      } else {
        supplementaryView.stopAnimationg()
      }
    }

    dataSource = DataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    })

    dataSource.supplementaryViewProvider = { (view, kind, index) in
      return view.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
    }

    var initialSnapshot = Snapshot()
    initialSnapshot.appendSections([.main])
    initialSnapshot.appendItems([])
    dataSource.apply(initialSnapshot, animatingDifferences: false)
  }

  public func refreshDataSource(_ items: [CellType.I]) {
    var snapshot = self.dataSource.snapshot()
    snapshot.appendItems(items)
    self.dataSource.apply(snapshot, animatingDifferences: false)
  }

  public func bindDataSource(_ items: [CellType.I]) {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(items, toSection: .main)
    self.dataSource.apply(snapshot)
  }
}
