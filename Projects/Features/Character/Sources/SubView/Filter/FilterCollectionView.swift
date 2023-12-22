//
//  FilterCollectionView.swift
//  Character
//
//  Created by Kanghos on 2023/12/17.
//

import UIKit

import SnapKit

class FilterCollectionView: UICollectionView {
  init(layout: UICollectionViewLayout = .tagLayout()) {
    super.init(frame: .zero, collectionViewLayout: layout)

    register(cellType: FilterCollectionViewCell.self)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
