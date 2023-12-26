//
//  CharacterSearchView.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/12/17.
//

import UIKit

import Core

import SnapKit

final class CharacterSearchView: RMBaseView, CollectionRepresentable {

  private(set) lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()

    return searchBar
  }()

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

  let filterCollectionView: FilterCollectionView = {
    let collectionView = FilterCollectionView()
    collectionView.backgroundColor = .white
    collectionView.isScrollEnabled = true
    return collectionView
  }()

  override func makeUI() {
    self.backgroundColor = .black

    addSubViews(filterCollectionView, collectionView, progressView)

    progressView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(100)
    }

    filterCollectionView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
      $0.height.equalTo(80)
    }

    collectionView.snp.makeConstraints {
      $0.top.equalTo(filterCollectionView.snp.bottom)
      $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
    }
  }
}
