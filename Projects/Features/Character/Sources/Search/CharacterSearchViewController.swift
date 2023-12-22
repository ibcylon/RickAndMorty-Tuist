//
//  CharacterSearchViewController.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/17.
//

import UIKit

import RxSwift
import RxCocoa

import Core

final class CharacterSearchViewController: CharacterDataSourceViewController {

  var viewModel: CharacterSearchViewModel!

  private let filterCollectionView: UICollectionView
  private let searchBar: UISearchBar

  public init(viewModel: CharacterSearchViewModel) {
    self.viewModel = viewModel
    let searchView = CharacterSearchView()
    self.searchBar = searchView.searchBar
    self.filterCollectionView = searchView.filterCollectionView
    super.init(mainView: searchView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  let backButton: UIBarButtonItem = .makeBackButton()
  let searchButton: UIBarButtonItem = .makeSearchButton()

  override func navigationSetting() {
    navigationItem.leftBarButtonItem = backButton
    navigationItem.titleView = self.searchBar
    navigationItem.rightBarButtonItem = searchButton
  }

  override func bindViewModel() {
    super.bindViewModel()

    let input = CharacterSearchViewModel.Input(
      searchText: searchBar.rx.text.orEmpty.asDriver(),
      searchTrigger: searchButton.rx.tap.asDriver(),
      onAppear: self.rx.viewWillAppear.map { _ in }.asDriver(onErrorJustReturn: ()),
      itemSelected: self.mainView.collectionView.rx.itemSelected.asDriver(),
      backButtonTap: self.backButton.rx.tap.asDriver(),
      filterItemSelected: self.filterCollectionView.rx.itemSelected.asDriver(),
      paging: pagingTrigger
    )

    let output = viewModel.transform(input: input)

    output.characterArray
      .drive(with: self, onNext: { owner, items in
        UIView.animate(withDuration: 0.4) {
          owner.mainView.collectionView.isHidden = false
          owner.mainView.collectionView.alpha = 1
        }
        owner.mainView.progressView.stopAnimating()
        owner.bindDataSource(items)
      })
      .disposed(by: disposeBag)
//
    output.hasNextPage
      .drive(hasNextPageRelay)
      .disposed(by: disposeBag)

    output.filterState
      .drive(filterCollectionView.rx.items(cellIdentifier: FilterCollectionViewCell.reuseIdentifier, cellType: FilterCollectionViewCell.self)) { index, item , cell in
        cell.bind(item)
      }
      .disposed(by: disposeBag)

    output.scrollToTop
      .drive(with: self, onNext: { owner, _ in
        owner.mainView.collectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .top, animated: true)
      })
      .disposed(by: disposeBag)
  }
}
