//
//  EpisodeDetailVIewController.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import EpisodeInterface

import CharacterInterface

import Core

public final class EpisodeDetailViewController: RMBaseViewController {

  fileprivate let mainView = EpisodeDetailView()

  fileprivate var dataSource: DataSource!

  public var viewModel: EpisodeDetailViewModel!

  var button = UIButton()

  public override func loadView() {
    self.view = mainView
  }

  public override func bindViewModel() {
    setupDataSource()

    let backButton = UIBarButtonItem(
      image: UIImage(systemName: "chevron.backward"),
      style: .plain,
      target: nil,
      action: nil
    )
    navigationItem.leftBarButtonItem = backButton
 
    backButton.rx.tap
      .asDriver()
      .debug("backbutton tap")
      .drive()
      .disposed(by: disposeBag)
    let input = EpisodeDetailViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }
        .asDriver(onErrorJustReturn: ()),
      backButtonTap: backButton.rx.tap.asDriver(),
      selectedCharacter: self.mainView.collectionView.rx.itemSelected
        .asDriver()
    )

    let output = viewModel.transform(input: input)

    output.item
      .drive(with: self, onNext: { owner, item in
        RMLogger.dataLogger.debug("items count: \(item.characters.count)")
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

extension EpisodeDetailViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<CharacterSection, RMCharacter>
  typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterSection, RMCharacter>

  enum CharacterSection: Hashable {
    case main
  }

  // MARK: - Private

  private func setupDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<RMCharacterCollectionViewCell, RMCharacter> { cell, indexPath, item in
      cell.configure(with: .init(item))
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
  func setupNavigationItem(target: Any?, action: Selector?) {
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold))
      ,
      style: .plain,
      target: target,
      action: action
    )
  }
}
