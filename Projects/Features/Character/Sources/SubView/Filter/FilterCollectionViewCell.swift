//
//  FilterCollectionViewCell.swift
//  Character
//
//  Created by Kanghos on 2023/12/17.
//

import UIKit

import Core
import SnapKit
import Domain

final class FilterCollectionViewCell: UICollectionViewCell, RMBaseViewType {

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .semibold)
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 10, weight: .regular)
    label.textColor = .darkGray
    label.textAlignment = .center
    return label
  }()

  private let selectedLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .semibold)
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()

  private let hStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
//    stackView.spacing = 5
    return stackView
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

    contentView.addSubview(hStackView)
    [titleLabel, nameLabel, selectedLabel].forEach {
      hStackView.addArrangedSubview($0)
    }
//    hStackView.setCustomSpacing(-5, after: nameLabel)
    hStackView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.height.equalTo(50).priority(.low)
      $0.bottom.equalToSuperview()
    }

    titleLabel.snp.makeConstraints {
      $0.width.equalTo(120).priority(.low)
      $0.height.equalTo(50)
    }

    nameLabel.snp.makeConstraints {
      $0.width.equalTo(120).priority(.low)
      $0.height.equalTo(20)
    }
    selectedLabel.snp.makeConstraints {
      $0.width.equalTo(120).priority(.low)
      $0.height.equalTo(30)
    }
  }

  private func setupLayer() {
    contentView.layer.cornerRadius = contentView.frame.height / 2
    contentView.layer.borderWidth = 2
    contentView.layer.borderColor = UIColor.lightGray.cgColor
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    setupLayer()
  }

  func bind(_ item: Filter.Item) {
    self.selectedLabel.isHidden = false
    self.nameLabel.isHidden = false
    self.titleLabel.isHidden = false

    self.titleLabel.text = item.name
    self.nameLabel.text = item.name
    self.selectedLabel.text = item.value

    if item.value == nil {
      self.selectedLabel.isHidden = true
      self.nameLabel.isHidden = true
    } else {
      titleLabel.isHidden = true
    }
  }
}
