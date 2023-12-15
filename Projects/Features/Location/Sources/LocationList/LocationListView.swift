//
//  LocationListView.swift
//  Location
//
//  Created by Kanghos on 2023/12/13.
//

import UIKit

import Core

import SnapKit

final class LocationListView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)

    makeUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  lazy var collectionView: UICollectionView = {
    let layout = createLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.backgroundView = RMEmptyView(title: "에러")
    collectionView.refreshControl = self.refreshControl
    return collectionView
  }()

  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    return refreshControl
  }()

  func makeUI() {
    self.addSubview(collectionView)

    collectionView.snp.makeConstraints {
      $0.edges.equalTo(self.safeAreaLayoutGuide)
    }
  }

  func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewFlowLayout()
    let bound = UIScreen.main.bounds
    let width = bound.width - 14 * 2
    let height = width * (108 / 358)
    layout.itemSize = CGSize(width: width, height: height)
    layout.footerReferenceSize = CGSize(width: layout.collectionViewContentSize.width, height: 100)
    layout.minimumLineSpacing = 8
    layout.scrollDirection = .vertical

    return layout
  }

  func stopProgress() {
    refreshControl.endRefreshing()
  }

  func startProgress() {
    
  }
}
