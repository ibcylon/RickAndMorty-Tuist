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

import Core

final class LocationListViewController: RMBaseViewController {

  private let mainView = LocationListView()
  var viewModel: LocationListViewModel!

  override func loadView() {
    self.view = mainView
  }

  override func makeUI() {
    self.title = "Locations"
  }

  override func bindViewModel() {
    let pagingTrigger = self.mainView.collectionView.rx.didScroll
      .filter { self.mainView.collectionView.needMorePage }
      .asDriver(onErrorDriveWith: .empty())

    let input = LocationListViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }.asDriver(onErrorJustReturn: ()),
      buttonTap: self.mainView.collectionView.rx.itemSelected.asDriver(),
      paging: pagingTrigger
    )

//    } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
//      let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath, cellType: RMFooterLoadingCollectionReusableView.self)
//      guard kind == UICollectionView.elementKindSectionFooter, hasNextPageRelay.value == true
//      else {
//        footer.stopAnimationg()
//        return footer
//      }
//      footer.startAnimating()
//      return footer
//    }

    let output = viewModel.transform(input: input)

    output.LocationArray
    .do(onNext: { [weak self] _ in
      UIView.animate(withDuration: 0.4) {
        self?.mainView.collectionView.isHidden = false
        self?.mainView.collectionView.alpha = 1
      }
      self?.mainView.progressView.stopAnimating()
    })
    .drive(self.mainView.collectionView.rx.items(
      cellIdentifier: RMLocationCollectionViewCell.reuseIdentifier,
      cellType: RMLocationCollectionViewCell.self)
    ) { index, model, cell in
        cell.configure(
          with: .init(
            name: model.name,
            status: model.status,
            imageURL: URL(string: model.image)
          )
        )
    }.disposed(by: disposeBag)

    output.route
    .drive()
    .disposed(by: disposeBag)
  }
}
