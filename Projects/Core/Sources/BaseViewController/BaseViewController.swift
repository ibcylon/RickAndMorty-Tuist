//
//  LogViewController.swift
//  Core
//
//  Created by Kanghos on 2023/12/06.
//

import UIKit

import RxSwift

open class RMBaseViewController: UIViewController, ViewControllable {
  public var disposeBag = DisposeBag()

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
    RMLogger.cycle(name: self)
  }

  open override func viewDidLoad() {
    super.viewDidLoad()

    RMLogger.ui.debug("\(#function) \(type(of: self))")
    navigationSetting()
    makeUI()
    bindViewModel()
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    RMLogger.cycle(name: self)
  }

  // MARK: - Open
  open func makeUI() { }

  open func bindViewModel() { }

  open func navigationSetting() {
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.titlePositionAdjustment.horizontal = -CGFloat.greatestFiniteMagnitude
    navBarAppearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25, weight: .semibold), .foregroundColor: UIColor.darkGray]
    navBarAppearance.backgroundColor = .white
    navBarAppearance.shadowColor = nil
    navigationItem.standardAppearance = navBarAppearance
    navigationItem.scrollEdgeAppearance = navBarAppearance
  }
}
