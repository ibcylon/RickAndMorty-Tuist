//
//  CharacterCollectionView.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/10.
//

import UIKit

import Core
import SnapKit

final class CharacterListView: RMBaseView, CharacterCollectionRepresentable {

  let searchButton = UIBarButtonItem(
    title: "Search",
    style: .plain,
    target: nil,
    action: nil
  )

  let progressView: UIActivityIndicatorView = {
    let progressView = UIActivityIndicatorView(style: .large)
    progressView.hidesWhenStopped = true
    return progressView
  }()

  let collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .createPagingGridLayout())
    collectionView.isHidden = true
    collectionView.alpha = 0
    collectionView.backgroundColor = .white
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
