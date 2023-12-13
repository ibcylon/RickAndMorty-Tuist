//
//  LaunchVIewController.swift
//  App
//
//  Created by Kanghos on 2023/11/30.
//

import UIKit

public final class RMLaunchViewController: RMBaseViewController {

  public override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = .orange

    let view = UIView()
    view.backgroundColor = .green
    view.bounds = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))

    view.center = self.view.center
    self.view.addSubview(view)
  }
  
  public override func navigationSetting() {

  }
}
