//
//  TypingBottomSheet.swift
//  Character
//
//  Created by Kanghos on 2023/12/18.
//

import UIKit

import RxSwift
import RxCocoa
import Core

final class TypingBottomSheet: RMBaseViewController {

  private let mainView = TypingBottomSheetView()

  var viewModel: TypingBottomSheetViewModel!

  override func loadView() {
    self.view = mainView
  }

  override func navigationSetting() {
    navigationItem.rightBarButtonItem = mainView.closeButton
  }

  override func bindViewModel() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTap))
    self.view.addGestureRecognizer(tapGesture)

    let cancel = mainView.closeButton.rx.tap.asDriver()
    let input = TypingBottomSheetViewModel.Input(
      filteredValue: mainView.textField.rx.text.orEmpty.asDriver(),
      cancelButtonTap: cancel,
      initButtonTap: mainView.initButton.rx.tap.asDriver(),
      confirmButtonTap: mainView.confirmButton.rx.tap.asDriver()
    )

    let output = self.viewModel.transform(input: input)

    output.item
      .drive(with: self) { owner, item in
        owner.mainView.textField.becomeFirstResponder()
        owner.navigationItem.title = item.name
        owner.mainView.bind(item)
      }.disposed(by: disposeBag)
  }

  @objc private func backgroundViewTap() {
    self.view.endEditing(true)
  }
}
