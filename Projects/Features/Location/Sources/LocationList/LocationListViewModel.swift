//
//  LocationListViewModel.swift
//  LocationInterface
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation

import RxSwift
import RxCocoa

import Core
import LocationInterface

protocol LocationSearchDelegate: AnyObject {
  func presentItem(item: RMLocation)
}

public final class LocationListViewModel: ViewModelType {
  private let useCase: FetchLocationUseCaseInterface

  var delegate: LocationSearchDelegate?

  init(useCase: FetchLocationUseCaseInterface) {
    self.useCase = useCase
  }

  public struct Input {
    let onAppear: Driver<Void>
    let buttonTap: Driver<IndexPath>
    let paging: Driver<Void>
  }

  public struct Output {
    let route: Driver<Void>
    let LocationArray: Driver<[RMLocation]>
  }
}

extension LocationListViewModel {
  public func transform(input: Input) -> Output {
    let onAppear = input.onAppear

    let info = onAppear
      .flatMapLatest { [weak self] in
        guard let self = self else { fatalError("self is nil") }
        return self.useCase.fetchSingleLocationByID(id: <#T##Int#>)
          .asDriver(onErrorDriveWith: .empty())
      }

    let list = info.map { $0.results }

    let route = input.buttonTap
      .withLatestFrom(list) { $1[$0.item] }
      .do(onNext: { [weak self] item in
        self?.delegate?.presentItem(item: item)
      }).map { _ in }

    return Output(
      route: route,
      LocationArray: list
    )
  }
}
