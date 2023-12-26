//
//  LocationListView.swift
//  Location
//
//  Created by Kanghos on 2023/12/13.
//

import UIKit

import Core

import SnapKit

final class LocationListView: RMBaseView, CollectionRepresentable {
  
  let progressView: UIActivityIndicatorView = {
    let progressView = UIActivityIndicatorView(style: .large)
    progressView.hidesWhenStopped = true
    return progressView
  }()

  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .createPagingListLayout())
    collectionView.backgroundColor = .white
    collectionView.backgroundView = RMEmptyView(title: "Location")
    collectionView.refreshControl = self.refreshControl
    return collectionView
  }()

  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    return refreshControl
  }()

  override func makeUI() {
    self.addSubViews(collectionView, progressView)

    progressView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(100)
    }

    collectionView.snp.makeConstraints {
      $0.edges.equalTo(self.safeAreaLayoutGuide)
    }
  }

  func stopProgress() {
    refreshControl.endRefreshing()
  }

  func startProgress() {
    
  }
}
