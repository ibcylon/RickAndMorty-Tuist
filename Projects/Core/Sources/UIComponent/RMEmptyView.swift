//
//  RMEmptyView.swift
//  Core
//
//  Created by Kanghos on 2023/12/13.
//

import UIKit

import SnapKit

public class RMEmptyView: UIView {
  private let title: String

  public lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = self.title
    return label
  }()

  public init(title: String) {
    self.title = title
    super.init(frame: .zero)

    makeUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open func makeUI() {
    self.backgroundColor = .systemGray2

    addSubview(titleLabel)

    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(-54)
      $0.height.equalTo(50)
    }
  }
}
