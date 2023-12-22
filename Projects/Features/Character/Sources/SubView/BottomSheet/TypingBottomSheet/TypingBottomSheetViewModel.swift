//
//  TypingBottomSheetViewModel.swift
//  Character
//
//  Created by Kanghos on 2023/12/19.
//

import Foundation

import Core

import RxSwift
import RxCocoa
import Domain

public class TypingBottomSheetViewModel: ViewModelType {
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
    let filteredValue: Driver<String>
    let cancelButtonTap: Driver<Void>
    let initButtonTap: Driver<Void>
    let confirmButtonTap: Driver<Void>
  }

  public struct Output {
    let item: Driver<Filter.Item>
  }

  public func transform(input: Input) -> Output {

    let typedValue = input.filteredValue

    let confirm = input.confirmButtonTap
      .withLatestFrom(typedValue)
      .map { str -> String? in
        str
      }
    let initFilter = input.initButtonTap
      .map { _ -> String? in
        return nil
      }

    Driver.merge(confirm, initFilter)
      .compactMap { [weak self] selected -> Filter.Item? in
        guard let self = self else { return nil }
        return self.item(filterType: self.filterType, selected: selected)
      }
      .drive(with: self, onNext: { owner, item in
        owner.listener?.setFilter(item: item)
        owner.delegate?.onDismiss()
      })
      .disposed(by: disposeBag)

    input.cancelButtonTap
      .drive(with: self) { owner, _ in
        owner.delegate?.onDismiss()
      }
      .disposed(by: disposeBag)

    return Output(
      item: Driver.just(self.filterType)
    )
  }

  fileprivate func item(filterType: Filter.Item, selected: String?) -> Filter.Item? {
    var item: Filter.Item?

    switch filterType {
    case .name:
      item = .name(selected)
    case .type:
      item = .type(selected)
    case .species:
      item = .species(selected)
    case .dimension:
      item = .dimension(selected)
    case .episode:
      item = .episode(selected)
    default:
      return nil
    }

    return item
  }
}
