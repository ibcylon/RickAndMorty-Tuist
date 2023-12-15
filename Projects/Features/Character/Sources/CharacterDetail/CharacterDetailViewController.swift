//
//  CharacterSearchViewController.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/03.
//

import UIKit

import RxSwift
import RxCocoa

import Core
import Domain

public final class CharacterDetailViewController: RMBaseViewController {

  fileprivate let mainView = RMCharacterDetailView()

  public var viewModel: CharacterDetailViewModel!
  
  fileprivate var dataSource: DataSource!

  public override func loadView() {
    self.view = mainView
  }

  public override func makeUI() {
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.prefersLargeTitles = false
  }

  public override func navigationSetting() {
    super.navigationSetting()
    navigationItem.standardAppearance?.titlePositionAdjustment = .zero
    navigationItem.leftBarButtonItem = mainView.backButton
  }

  public override func bindViewModel() {
    setupDataSource()

    let input = CharacterDetailViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }
        .asDriver(onErrorJustReturn: ()),
      selectedLocation: self.mainView.locationButton.rx.tap.asDriver(),
      selectedEpisode: self.mainView.episodeCollectionView.rx.itemSelected.asDriver(),
      backButtonTap: self.mainView.backButton.rx.tap.asDriver()
    )

    let output = viewModel.transform(input: input)

    output.item
      .drive(with: self, onNext: { owner, item in
        owner.mainView.bind(item: item)
        owner.navigationItem.title = item.name
      })
      .disposed(by: disposeBag)

    output.episodes
      .drive(with: self, onNext: { owner, items in
        owner.mainView.episodeCollectionView.isHidden = false
        UIView.animate(withDuration: 0.4) {
//          owner.mainView.episodeCollectionView.isHidden = false
//          owner.mainView.episodeCollectionView.alpha = 1
        }
        owner.refreshDataSource(items)
      })
      .disposed(by: disposeBag)
  }
}


extension CharacterDetailViewController {
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

    dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.episodeCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    })

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


