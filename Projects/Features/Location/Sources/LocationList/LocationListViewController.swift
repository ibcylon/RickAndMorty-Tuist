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

final class LocationListViewController: BaseDiffableDataSourceViewController<LocationListCell, LocationListCell.Item> {
  private let viewModel: LocationListViewModel

  init(viewModel: LocationListViewModel!) {
    self.viewModel = viewModel
    let mainView = LocationListView()
    super.init(mainView: mainView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func makeUI() {
    self.navigationItem.title = "Locations"
  }

  override func bindViewModel() {
    super.bindViewModel()

    let input = LocationListViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }.asDriver(onErrorDriveWith: .empty()),
      buttonTap: self.mainView.collectionView.rx.itemSelected.asDriver().debug("Item"),
      paging: pagingTrigger
        .debug("paging")
    )

    let output = viewModel.transform(input: input)

    output.LocationArray
      .drive(with: self, onNext: { owner, items in
        RMLogger.dataLogger.debug("location items count: \(items.count)")
        owner.refreshDataSource(items)
      }).disposed(by: disposeBag)

    output.hasNextPage
      .debug("location NextPage")
      .drive(hasNextPageRelay)
      .disposed(by: disposeBag)
  }
}

