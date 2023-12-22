//
//  ChooseBottomSheetView.swift
//  Character
//
//  Created by Kanghos on 2023/12/18.
//

import UIKit

import Core

import SnapKit

class ChooseBottomSheetView: RMBaseView {
  private(set) lazy var closeButton = UIBarButtonItem(
    image: UIImage(systemName: "xmark.circle.fill"),
    style: .plain,
    target: nil,
    action: nil)

  private(set) lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: .createListLayout(ratio: 1 / 6)
    )
    collectionView.register(cellType: ListCollectionViewCell.self)
    return collectionView
  }()

  private(set) lazy var buttonHStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    return stackView
  }()

  private(set) lazy var initializeButton: UIButton = {
    let button = UIButton()
    button.setTitle("initialize", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    button.backgroundColor = .white
    button.setTitleColor(.systemBlue, for: .normal)
    button.layer.cornerRadius = 8
    return button
  }()

  override func makeUI() {
    self.backgroundColor = collectionView.backgroundColor
    let spacer = UIView()
    addSubViews(collectionView, buttonHStackView, spacer)

    [initializeButton].forEach {
      buttonHStackView.addArrangedSubview($0)
    }

    collectionView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
    }
    buttonHStackView.snp.makeConstraints {
      $0.top.equalTo(collectionView.snp.bottom).offset(10)
      $0.height.equalTo(50)
      $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(30)
    }
    spacer.snp.makeConstraints {
      $0.leading.trailing.equalTo(safeAreaLayoutGuide)
      $0.top.equalTo(buttonHStackView.snp.bottom).offset(50)
      $0.bottom.equalTo(self.snp.bottom)
    }
  }
}

