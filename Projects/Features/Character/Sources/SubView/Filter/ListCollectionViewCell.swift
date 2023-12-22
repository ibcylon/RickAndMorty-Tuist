//
//  LIstCollectionViewCell.swift
//  Character
//
//  Created by Kanghos on 2023/12/18.
//

import UIKit

import Core
import SnapKit

final class ListCollectionViewCell: UICollectionViewCell, RMBaseViewType {

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .semibold)
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: .zero)

    makeUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func makeUI() {
    contentView.backgroundColor = .white

    contentView.addSubview(titleLabel)

    titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    titleLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.height.equalTo(40).priority(.low)
      $0.width.equalTo(100).priority(.low)
      $0.bottom.equalToSuperview()
    }
  }

  private func setupLayer() {
    contentView.layer.cornerRadius = contentView.frame.height / 2
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.lightGray.cgColor
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupLayer()
  }

  func bind(_ value: String) {
    self.titleLabel.text = value
  }
}
