//
//  EpisodeListView.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit

import Core
import SnapKit

final class EpisodeListView: RMBaseView {

  lazy var progressView: UIActivityIndicatorView = {
    let progressView = UIActivityIndicatorView(style: .large)
    progressView.hidesWhenStopped = true
    return progressView
  }()

  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: .createPagingGridLayout(ratio: 0.80)
    )
    collectionView.isHidden = true
    collectionView.alpha = 0
    collectionView.backgroundColor = .white
    collectionView.backgroundView = RMEmptyView(title: "에피소드")

    return collectionView
  }()

  override func makeUI() {
    addSubViews(collectionView, progressView)

    progressView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(100)
    }

    collectionView.snp.makeConstraints {
      $0.edges.equalTo(safeAreaLayoutGuide)
    }
  }
}
