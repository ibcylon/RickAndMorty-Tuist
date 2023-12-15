//
//  LocationSearchViewController.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/03.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

import LocationInterface

import Core

final class LocationListViewController: RMBaseViewController {
  fileprivate var dataSource: DataSource!
  fileprivate let hasNextPageRelay = BehaviorRelay<Bool>(value: false)
  fileprivate let mainView = LocationListView()
  var viewModel: LocationListViewModel!

  override func loadView() {
    self.view = mainView
  }

  override func makeUI() {
    self.navigationItem.title = "Locations"
    self.setupDataSource()
  }

  override func bindViewModel() {
    let pagingTrigger = self.mainView.collectionView.rx.didScroll
      .asDriver()
      .filter { self.mainView.collectionView.needMorePage }

    let input = LocationListViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }.asDriver(onErrorDriveWith: .empty()),
      buttonTap: self.mainView.collectionView.rx.itemSelected.asDriver(),
      paging: pagingTrigger
    )

    let output = viewModel.transform(input: input)
    output.LocationArray
      .drive(with: self, onNext: { owner, items in
        owner.mainView.stopProgress()
        owner.refreshDataSource(items)
      }).disposed(by: disposeBag)

    output.route
      .disposed(by: disposeBag)

    output.hasNextPage
      .drive(hasNextPageRelay)
      .disposed(by: disposeBag)
  }
}

extension LocationListViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<LocationSection, RMLocation>
  typealias Snapshot = NSDiffableDataSourceSnapshot<LocationSection, RMLocation>

  enum LocationSection: Hashable {
    case main
  }
  // MARK: - Private
  private func setupDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<LocationListCell, RMLocation> { cell, indexPath, item in
      cell.bind(viewModel: item)
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

  fileprivate func refreshDataSource(_ items: [RMLocation]) {
    var snapshot = dataSource.snapshot()
    snapshot.appendItems(items)
    self.dataSource.apply(snapshot)
  }

  fileprivate func stopProgress() {
    mainView.stopProgress()
  }
}

extension RMLocation: Hashable {
  public static func == (lhs: RMLocation, rhs: RMLocation) -> Bool {
    lhs.id == rhs.id
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}


