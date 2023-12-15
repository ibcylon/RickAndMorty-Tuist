//
//  LocationDetailView.swift
//  Location
//
//  Created by Kanghos on 2023/12/13.
//

import UIKit

import LocationInterface
import Core

final class LocationDetailView: UIView {
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    return label
  }()

  private lazy var typeLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    return label
  }()

  private lazy var dimensionLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    return label
  }()

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let contentSize = layout.collectionViewContentSize.width
    let width = (contentSize - 30) / 2
    layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isHidden = false
    collectionView.alpha = 1
    collectionView.backgroundColor = .white
    collectionView.delegate = self
    collectionView.backgroundView = RMEmptyView(title: "no data")
    return collectionView
  }()

  init() {
    super.init(frame: .zero)
    makeUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func makeUI() {
    [
      nameLabel, typeLabel, dimensionLabel,
      collectionView
    ].forEach { addSubview($0) }

    nameLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(15)
      $0.height.equalTo(50)
    }

    typeLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom)
      $0.height.leading.trailing.equalTo(nameLabel)
    }

    dimensionLabel.snp.makeConstraints {
      $0.top.equalTo(typeLabel.snp.bottom)
      $0.height.leading.trailing.equalTo(nameLabel)
    }
    
    collectionView.snp.makeConstraints {
      $0.leading.trailing.equalTo(nameLabel)
      $0.top.equalTo(dimensionLabel.snp.bottom)
      $0.bottom.equalTo(safeAreaLayoutGuide)
    }
  }

  func bind(_ item: RMLocation) {
    nameLabel.text = item.name
    typeLabel.text = item.type
    dimensionLabel.text = item.dimension
  }
}

extension LocationDetailView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.bounds.width - 30) / 2
    let height = width * 1.5

    return CGSize(
      width: width,
      height: height
    )
  }
}
