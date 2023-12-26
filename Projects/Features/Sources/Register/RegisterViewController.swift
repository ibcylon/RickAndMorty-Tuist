//
//  RegisterViewController.swift
//  Feature
//
//  Created by Kanghos on 2023/12/01.
//

import UIKit

import Core

import RxSwift
import RxCocoa

protocol RegisterViewDelegate: AnyObject {
  func finishLogin()
}

final class RegisterViewController: RMBaseViewController {
  weak var delegate: RegisterViewDelegate?
  let logoutButton = UIBarButtonItem.makeImageBarButton(type: .logout)

  override func makeUI() {
    self.view.backgroundColor = .magenta
    self.title = "Register"
  }

  override func navigationSetting() {
    super.navigationSetting()
    navigationItem.rightBarButtonItem = logoutButton
  }


  override func bindViewModel() {
    logoutButton.rx.tap.asDriver()
      .drive(with: self) { owner, _ in
        owner.delegate?.finishLogin()
      }.disposed(by: disposeBag)
  }
}
