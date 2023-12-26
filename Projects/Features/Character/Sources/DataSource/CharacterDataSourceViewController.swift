//
//  CharacterDataSourceViewController.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/17.
//

import UIKit
import SwiftUI

import SnapKit
import RxSwift
import RxCocoa
import CachedAsyncImage

import CharacterInterface
import Core

class CharacterDataSourceViewController: RMBaseViewController {

  let mainView: CharacterCollectionRepresentable

  init(mainView: CharacterCollectionRepresentable) {
    self.mainView = mainView
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate var dataSource: DataSource!
  let hasNextPageRelay = BehaviorRelay<Bool>(value: false)

  override func loadView() {
    self.view = mainView
  }

  override func bindViewModel() {
    setupDataSource()
  }
}

extension CharacterDataSourceViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<CharacterSection, RMCharacter>
  typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterSection, RMCharacter>

  enum CharacterSection: Hashable {
    case main
  }

  private var hasPage: Bool {
    self.hasNextPageRelay.value
  }

  var pagingTrigger: Driver<Void> {
    self.mainView.collectionView.rx.didEndDecelerating
      .asDriver()
      .filter { [weak self] in
        guard let self = self else { return false }
        return self.mainView.collectionView.needMorePage
      }
  }

  // MARK: - Private
  private func setupDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<RMCharacterCollectionViewCell, RMCharacter> { cell, indexPath, item in
      cell.configure(with: .init(item))
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
      if self?.hasPage == true {
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

  func refreshDataSource(_ items: [RMCharacter]) {
    var snapshot = self.dataSource.snapshot()
    snapshot.appendItems(items)
    self.dataSource.apply(snapshot)
  }

  func bindDataSource(_ items: [RMCharacter]) {
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems(items, toSection: .main)
    self.dataSource.apply(snapshot)
  }
}
