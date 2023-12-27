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

public final class CharacterDetailViewController: BaseDiffableDataSourceViewController<RMEpisodeCollectionViewCell, RMEpisodeCollectionViewCell.Item> {

  private let viewModel: CharacterDetailViewModel
  private let detailView: CharacterDetailView

  public init(viewModel: CharacterDetailViewModel) {
    self.detailView = CharacterDetailView()
    self.viewModel = viewModel
    super.init(mainView: detailView)
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func makeUI() {
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.prefersLargeTitles = false
  }

  public override func navigationSetting() {
    super.navigationSetting()
    navigationItem.standardAppearance?.titlePositionAdjustment = .zero
    navigationItem.leftBarButtonItem = detailView.backButton
  }

  public override func bindViewModel() {
    super.bindViewModel()

    let input = CharacterDetailViewModel.Input(
      onAppear: self.rx.viewWillAppear.map { _ in }
        .asDriver(onErrorJustReturn: ()),
      selectedLocation: detailView.locationButton.rx.tap.asDriver(),
      selectedEpisode: self.mainView.collectionView.rx.itemSelected.asDriver(),
      backButtonTap: detailView.backButton.rx.tap.asDriver()
    )

    let output = viewModel.transform(input: input)

    output.item
      .drive(with: self, onNext: { owner, item in
        owner.detailView.bind(item: item)
        owner.navigationItem.title = item.name
      })
      .disposed(by: disposeBag)

    output.episodes
      .drive(with: self, onNext: { owner, items in
        owner.mainView.collectionView.isHidden = false
        UIView.animate(withDuration: 0.4) {
          owner.mainView.collectionView.isHidden = false
          owner.mainView.collectionView.alpha = 1
        }
        owner.refreshDataSource(items)
      })
      .disposed(by: disposeBag)
  }
}
