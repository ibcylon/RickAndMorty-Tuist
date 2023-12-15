//
//  RMEpisodeCell.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit

import Core

import SnapKit

public final class RMEpisodeCollectionViewCell: UICollectionViewCell {

  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = .systemFont(ofSize: 18, weight: .semibold)
    label.numberOfLines = 2
    return label
  }()

  private lazy var airDateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 12, weight: .medium)
    return label
  }()

  private lazy var episodeLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    return label
  }()

  public override init(frame: CGRect) {
    super.init(frame: .zero)
    contentView.backgroundColor = .secondarySystemBackground

    makeUI()
  }

  public override func prepareForReuse() {
    nameLabel.text = ""
    episodeLabel.text = ""
    airDateLabel.text = ""
    super.prepareForReuse()
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func makeUI() {
    contentView.addSubViews(nameLabel, episodeLabel, airDateLabel)

    setUpLayers()

    episodeLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(10)
      $0.height.equalTo(40)
    }
    airDateLabel.snp.makeConstraints {
      $0.top.equalTo(episodeLabel.snp.bottom)
      $0.leading.trailing.equalTo(episodeLabel)
      $0.height.equalTo(30)
    }
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(airDateLabel.snp.bottom)
      $0.leading.trailing.equalTo(episodeLabel)
      $0.height.equalTo(50).priority(.low)
      $0.bottom.equalToSuperview().offset(-10)
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

  public func configure(with viewModel: RMEpisode) {
    self.nameLabel.text = viewModel.name
    self.episodeLabel.text = viewModel.episode
    self.airDateLabel.text = viewModel.airDate
  }
}
