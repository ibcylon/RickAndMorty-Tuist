//
//  RMBaseView.swift
//  Core
//
//  Created by Kanghos on 2023/12/14.
//

import UIKit

open class RMBaseView: UIView, RMBaseViewType {
  public init() {
    super.init(frame: .zero)
    makeUI()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open func makeUI() {

  }
}
