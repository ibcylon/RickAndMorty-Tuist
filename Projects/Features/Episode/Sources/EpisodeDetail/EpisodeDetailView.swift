//
//  EpisodeDetailView.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit

import EpisodeInterface
import Core

final class EpisodeDetailView: RMBaseView {

  private lazy var episodeLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .medium)
    label.textColor = .secondaryLabel
    return label
  }()

  private lazy var airDataLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .regular)
    label.textColor = .secondaryLabel
    return label
  }()

  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .createGridLayout()
    )
    collectionView.isHidden = false
    collectionView.alpha = 1
    collectionView.backgroundColor = .white
    collectionView.backgroundView = RMEmptyView(title: "no data")
    return collectionView
  }()

  override func makeUI() {
    self.backgroundColor = .black
    [
      episodeLabel, airDataLabel,
      collectionView
    ].forEach { addSubview($0) }

    episodeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    episodeLabel.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.leading.equalTo(safeAreaLayoutGuide).offset(15)
      $0.height.equalTo(50)
    }

    airDataLabel.snp.makeConstraints {
      $0.centerY.equalTo(episodeLabel)
      $0.leading.equalTo(episodeLabel.snp.trailing).offset(10)
      $0.trailing.equalTo(safeAreaLayoutGuide).inset(15)
    }

    collectionView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(episodeLabel.snp.bottom)
      $0.bottom.equalTo(safeAreaLayoutGuide)
    }
  }

  func bind(_ item: RMEpisode) {
    episodeLabel.text = item.episode
    airDataLabel.text = item.airDate
  }
}
