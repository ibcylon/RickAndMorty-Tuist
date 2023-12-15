//
//  RMPagingFooterView.swift
//  Core
//
//  Created by Kanghos on 2023/12/13.
//

import UIKit

import SnapKit

public final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
  private let progressView: UIActivityIndicatorView = {
    let progress = UIActivityIndicatorView(style: .large)
    progress.hidesWhenStopped = true
    return progress
  }()

  private lazy var lastPageLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setUpViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpViews() {
    backgroundColor = .darkGray

    self.addSubview(lastPageLabel)
    self.addSubview(progressView)

    progressView.snp.makeConstraints {
      $0.size.equalTo(100)
      $0.center.equalToSuperview()
    }

    lastPageLabel.snp.makeConstraints {
      $0.center.equalTo(progressView)
      $0.height.equalTo(50)
      $0.width.equalToSuperview().inset(10)
    }
  }
  public override func prepareForReuse() {
    lastPageLabel.text = ""
    super.prepareForReuse()
  }

  public func startAnimating() {
    progressView.startAnimating()
  }

  public func stopAnimationg() {
    progressView.stopAnimating()
    lastPageLabel.text = "Last Page - no more contents"
  }
}

