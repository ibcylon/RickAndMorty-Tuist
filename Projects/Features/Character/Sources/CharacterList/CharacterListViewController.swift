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

final class CharacterListViewController: RMBaseViewController {

  private let mainView = CharacterListView()
  var viewModel: CharacterListViewModel!

  fileprivate var dataSource: DataSource!
  fileprivate let hasNextPageRelay = BehaviorRelay<Bool>(value: false)

  override func loadView() {
    self.view = mainView
  }

  override func makeUI() {
    self.title = "Characters"
  }

  override func navigationSetting() {
    super.navigationSetting()
    navigationItem.rightBarButtonItem = mainView.searchButton
  }

  override func bindViewModel() {
    setupDataSource()

    let pagingTrigger = self.mainView.collectionView.rx.didEndDecelerating
      .filter { self.mainView.collectionView.needMorePage }
      .asDriver(onErrorDriveWith: .empty())

    let input = CharacterListViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }.asDriver(onErrorJustReturn: ()),
      itemSelected: self.mainView.collectionView.rx.itemSelected.asDriver(),
      search:
        self.mainView.searchButton.rx.tap.asDriver(),
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
        owner.refreshDataSource(items)
      })
      .disposed(by: disposeBag)

    output.hasNextPage
      .drive(hasNextPageRelay)
      .disposed(by: disposeBag)
  }
}

extension CharacterListViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<CharacterSection, RMCharacter>
  typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterSection, RMCharacter>

  enum CharacterSection: Hashable {
    case main
  }
  // MARK: - Private
  private func setupDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<RMCharacterCollectionViewCell, RMCharacter> { cell, indexPath, item in
      //      cell.configure(with: .init(item))
      cell.contentConfiguration = UIHostingConfiguration {
        ZStack {
          Color(.black)
            .overlay(
              VStack {
                CachedAsyncImage(
                  url: URL(string: item.image),
                  urlCache: .imageCache
                ) { image in
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerSize: CGSize.init(width: 10, height: 10)))
                } placeholder: {
                  ProgressView()
                }

                Text(item.status.rawValue)
                  .fontWeight(.semibold)
                  .foregroundStyle(.white)
                Text(item.name)
                  .foregroundStyle(.white)
                Spacer()
              }
            )
        }
      }
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

  fileprivate func refreshDataSource(_ items: [RMCharacter]) {
    var snapshot = self.dataSource.snapshot()
    snapshot.appendItems(items)
    self.dataSource.apply(snapshot)
  }
}
