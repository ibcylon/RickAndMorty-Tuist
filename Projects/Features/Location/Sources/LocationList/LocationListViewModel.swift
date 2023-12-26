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
  func presentItem(_ item: RMLocation)
}

public final class LocationListViewModel: ViewModelType {
  private let useCase: FetchLocationUseCaseInterface

  weak var delegate: LocationSearchDelegate?

  init(useCase: FetchLocationUseCaseInterface) {
    self.useCase = useCase
  }

  public struct Input {
    let onAppear: Driver<Void>
    let buttonTap: Driver<IndexPath>
    let paging: Driver<Void>
  }

  public struct Output {
    let route: Disposable
    let LocationArray: Driver<[RMLocation]>
    let hasNextPage: Driver<Bool>
  }
}

extension LocationListViewModel {
  public func transform(input: Input) -> Output {
    let store = BehaviorRelay<RMLocationInfo?>(value: nil)
    let loadedList = BehaviorRelay<[RMLocation]>(value: [])

    let onAppear = input.onAppear
      .withLatestFrom(loadedList.asDriver())
      .filter { $0.isEmpty }
      .map { _ in }

    let pagingTrigger = input.paging
      .debounce(.seconds(1))

    let addedList = Driver.merge(pagingTrigger, onAppear)
      .withLatestFrom(store.asDriver())
      .asObservable()
      .flatMapLatest(weak: self) { owner, currentStore -> Observable<RMLocationInfo> in
        guard let currentStore = currentStore else {
          return owner.useCase.fetchAllLocations(page: 1)
        }
        guard let nextPage = currentStore.info.nextPagenumber else {
          return .empty()
        }
        return owner.useCase.fetchAllLocations(page: nextPage)
      }
      .asDriver(onErrorDriveWith: .empty())
      .map { info -> [RMLocation] in
        store.accept(info)
        var mutable = loadedList.value
        mutable.append(contentsOf: info.results)
        loadedList.accept(mutable)
        return info.results
      }

    let route = input.buttonTap
      .withLatestFrom(loadedList.asDriver()) { indexPath, array in
        RMLogger.dataLogger.debug("\(indexPath)")
        RMLogger.dataLogger.debug("\(array.count)")
        return array[indexPath.item]
      }
      .drive(with: self, onNext: { owner, item in
        owner.delegate?.presentItem(item)
      })

    let hasNextPage = store
      .map { $0?.info.next == nil ? false : true }
      .asDriver(onErrorJustReturn: false)

    return Output(
      route: route,
      LocationArray: addedList,
      hasNextPage: hasNextPage
    )
  }
}

extension ObservableType {
  func flatMapLatest<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
    return flatMapLatest { [weak obj] value -> Observable<O.Element> in
      try obj.map { try selector($0, value).asObservable() } ?? .empty() }
  }
}
