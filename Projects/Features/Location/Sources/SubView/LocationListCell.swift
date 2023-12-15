//
//  LocationListCell.swift
//  Location
//
//  Created by Kanghos on 2023/12/13.
//

import UIKit

import Core
import LocationInterface

import SnapKit

final class LocationListCell: UICollectionViewCell {

  private lazy var vStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    return stackView
  }()
  private lazy var nameLabel: UILabel = {
    let label = UILabel()

    return label
  }()

  private lazy var typeLabel: UILabel = {
    let label = UILabel()

    return label
  }()

  private lazy var dimensionLabel: UILabel = {
    let label = UILabel()

    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    makeUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    nameLabel.text = ""
    typeLabel.text = ""
    dimensionLabel.text = ""
    super.prepareForReuse()
  }

  private func makeUI() {
    contentView.addSubview(vStackView)
    [
      nameLabel, typeLabel, dimensionLabel
    ].forEach {
      vStackView.addArrangedSubview($0)
//      $0.snp.makeConstraints {
//        $0.height.equalTo(50)
//      }
    }

    vStackView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(10)
      $0.trailing.bottom.equalToSuperview().offset(-10)
    }
  }

  func bind(viewModel item: RMLocation) {
    self.nameLabel.text = item.name
    self.dimensionLabel.text = item.dimension
    self.typeLabel.text = item.type
  }
}
