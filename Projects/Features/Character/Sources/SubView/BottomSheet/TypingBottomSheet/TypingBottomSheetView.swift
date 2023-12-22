//
//  TypingBottomSheetView.swift
//  Character
//
//  Created by Kanghos on 2023/12/19.
//

import UIKit

import Core
import Domain

import SnapKit

final class TypingBottomSheetView: RMBaseView {

  private(set) lazy var closeButton = UIBarButtonItem(
    image: UIImage(systemName: "xmark.circle.fill"),
    style: .plain,
    target: nil,
    action: nil)

  private(set) lazy var textField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .white
    textField.textColor = .darkGray
    return textField
  }()

  private(set) lazy var buttonHStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    return stackView
  }()

  private(set) lazy var initButton: UIButton = {
    let button = UIButton()
    button.setTitle("initialize", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    button.backgroundColor = .white
    button.setTitleColor(.systemBlue, for: .normal)
    button.layer.cornerRadius = 8
    return button
  }()

  private(set) lazy var confirmButton: UIButton = {
    let button = UIButton()
    button.setTitle("confirm", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    button.backgroundColor = .systemBlue
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 8
    return button
  }()

  override func makeUI() {

    self.backgroundColor = .darkGray.withAlphaComponent(0.8)
    let spacer = UIView()
    addSubViews(textField, buttonHStackView, spacer)

    [initButton, confirmButton].forEach {
      buttonHStackView.addArrangedSubview($0)
    }

    textField.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide).offset(50)
      $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(30)
      $0.height.equalTo(50)
    }

    buttonHStackView.snp.makeConstraints {
      $0.top.equalTo(textField.snp.bottom).offset(30)
      $0.height.equalTo(50)
      $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(30)
    }
    
    spacer.snp.makeConstraints {
      $0.leading.trailing.equalTo(safeAreaLayoutGuide)
      $0.top.equalTo(buttonHStackView.snp.bottom)
      $0.bottom.equalTo(self.snp.bottom)
    }
  }

  public func bind(_ filter: Filter.Item) {
    textField.placeholder = "\(filter.name)을(를) 입력해주세요"
  }
}

