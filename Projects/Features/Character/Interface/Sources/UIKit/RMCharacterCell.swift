//
//  RMCharacterCell.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/09.
//

import UIKit
import Core

import SnapKit

public final class RMCharacterCollectionViewCell: UICollectionViewCell {
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = .systemFont(ofSize: 16, weight: .medium)
    return label
  }()
  private lazy var statusLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 16, weight: .regular)
    return label
  }()

  public override init(frame: CGRect) {
    super.init(frame: .zero)
    contentView.backgroundColor = .secondarySystemBackground

    setUpView()
  }

  public override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    nameLabel.text = ""
    statusLabel.text = ""
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpView() {
    contentView.addSubViews(imageView, nameLabel, statusLabel)
    setUpLayers()
    imageView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
    }
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(imageView).inset(7)
      $0.height.equalTo(30)
    }
    statusLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom)
      $0.leading.trailing.height.equalTo(nameLabel)
      $0.bottom.equalToSuperview().inset(3)
    }
  }
  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    setUpLayers()
  }

  private func setUpLayers() {
    contentView.layer.cornerRadius = 8
    contentView.layer.shadowColor = UIColor.label.cgColor

    contentView.layer.shadowOffset = .init(width: -4, height: 4)
    contentView.layer.shadowRadius = 8
    contentView.layer.shadowOpacity = 0.3
  }

  public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
    self.nameLabel.text = viewModel.name
    self.statusLabel.text = viewModel.statusText
    self.imageView.setImage(url: viewModel.image)
  }
}
