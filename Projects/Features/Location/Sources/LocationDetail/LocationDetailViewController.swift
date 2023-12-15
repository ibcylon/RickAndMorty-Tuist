//
//  CharacterSearchViewController.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/03.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import CharacterInterface

import Core

public final class LocationDetailViewController: RMBaseViewController {

  fileprivate let mainView = LocationDetailView()

  fileprivate var dataSource: DataSource!

  public var viewModel: LocationDetailViewModel!

  var button = UIButton()

  public override func loadView() {
    self.view = mainView
  }

  public override func bindViewModel() {
    setupDataSource()

    let input = LocationDetailViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }
        .asDriver(onErrorJustReturn: ()),
      backButtonTap: self.button.rx.tap.asDriver(),
      selectedCharacter: self.mainView.collectionView.rx.itemSelected
        .asDriver()
    )

    let output = viewModel.transform(input: input)

    output.item
      .drive(with: self, onNext: { owner, item in
        RMLogger.dataLogger.debug("items count: \(item.residents.count)")
        owner.mainView.bind(item)
        owner.title = item.name
      })
      .disposed(by: disposeBag)

    output.residents
      .drive(with: self) { owner, residents in
        owner.refreshDataSource(residents)
      }.disposed(by: disposeBag)
  }
}

// MARK: DatsSource

extension LocationDetailViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<CharacterSection, RMCharacter>
  typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterSection, RMCharacter>

  enum CharacterSection: Hashable {
    case main
  }

  // MARK: - Private
  
  private func setupDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<RMCharacterCollectionViewCell, RMCharacter> { cell, indexPath, item in
      cell.configure(with: .init(name: item.name, status: item.status, imageURL: URL(string: item.image)))
    }

    dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    })

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
