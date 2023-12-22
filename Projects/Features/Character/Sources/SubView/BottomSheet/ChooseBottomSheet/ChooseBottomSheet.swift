//
//  ChooseBottomSheet.swift
//  Character
//
//  Created by Kanghos on 2023/12/18.
//

import UIKit
import SwiftUI

import RxSwift
import RxCocoa
import Core

final class ChooseBottomSheet: RMBaseViewController {

  private let mainView = ChooseBottomSheetView()

  var viewModel: ChooseBottomSheetViewModel!
  
  override func loadView() {
    self.view = mainView
  }

  override func navigationSetting() {
    navigationItem.rightBarButtonItem = mainView.closeButton
  }

  override func bindViewModel() {

    let itemSelected = mainView.collectionView.rx.itemSelected
      .asDriver()
      .map { [weak self] indexpath in
        self?.mainView.collectionView.deselectItem(
          at: indexpath, animated: true)
        return indexpath
      }
    
    let input = ChooseBottomSheetViewModel.Input(
      selectedItem: itemSelected,
      cancelButtonTap: mainView.closeButton.rx.tap.asDriver(),
      initializeButtonTap: mainView.initializeButton.rx.tap.asDriver()
    )

    let output = self.viewModel.transform(input: input)

    output.items
      .drive(self.mainView.collectionView.rx.items(
        cellIdentifier: ListCollectionViewCell.reuseIdentifier,
        cellType: ListCollectionViewCell.self
      )) { index, model, cell in
        cell.contentConfiguration = UIHostingConfiguration {
          VStack {
            Text(model)
          }
        }
        cell.bind(model)
      }
      .disposed(by: disposeBag)
  }

}
