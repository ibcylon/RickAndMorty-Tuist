//
//  ChooseBottomSheetViewModel.swift
//  Character
//
//  Created by Kanghos on 2023/12/18.
//

import Foundation

import Core

import RxSwift
import RxCocoa
import Domain

public protocol BottomSheetViewModelDelegate: AnyObject {
  func onDismiss()
}

public class ChooseBottomSheetViewModel: ViewModelType {
  public typealias Item = Filter.Item
  private let filterType: Item

  weak var listener: BottomSheetListener?
  weak var delegate: BottomSheetViewModelDelegate?

  private var disposeBag = DisposeBag()

  public init(filterType: Filter.Item) {
    self.filterType = filterType
  }

  deinit { RMLogger.cycle(name: self) }

  public struct Input {
    let selectedItem: Driver<IndexPath>
    let cancelButtonTap: Driver<Void>
    let initializeButtonTap: Driver<Void>
  }

  public struct Output {
    let items: Driver<[String]>
  }

  public func transform(input: Input) -> Output {
    let outputItems = Driver.just(filterType.options)

    input.cancelButtonTap
      .drive(with: self) { owner, _ in
        owner.delegate?.onDismiss()
      }
      .disposed(by: disposeBag)


    let selectedItem = input.selectedItem
      .withLatestFrom(outputItems) { index, array -> String? in
        array[index.item]
      }
    Driver.merge(
      selectedItem,
      input.initializeButtonTap.map { _ -> String? in
        return nil }
    )
    .compactMap { [weak self] selected -> Filter.Item? in
        guard let self = self else { return nil }
        return self.item(filterType: self.filterType, selected: selected)
      }
      .drive(with: self) { owner, item in
        owner.listener?.setFilter(item: item)
        owner.delegate?.onDismiss()
      }
      .disposed(by: disposeBag)

    return Output(
      items: outputItems
    )
  }

  fileprivate func item(filterType: Filter.Item, selected: String?) -> Filter.Item? {
    var item: Filter.Item?

    if case .gender = filterType {
      guard let selected = selected else {
        item = .gender(nil)
        return item
      }
      item = .gender(RMGender(rawValue: selected))
    }
    if case .status = filterType {
      guard let selected = selected else {
        item = .status(nil)
        return item
      }
      item = .status(RMCharacterStatus(rawValue: selected))
    }
    return item
  }
}
