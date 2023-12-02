//
//  LaunchVIewController.swift
//  App
//
//  Created by Kanghos on 2023/11/30.
//

import UIKit

final class RMLaunchViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let label = UILabel()
    label.text = "런치 스크린"
    label.font = .systemFont(ofSize: 25, weight: .semibold)

    self.view.addSubview(label)
    self.view.backgroundColor = .orange
  }
}
