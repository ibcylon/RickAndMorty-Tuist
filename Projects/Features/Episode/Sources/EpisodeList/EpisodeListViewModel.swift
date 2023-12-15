//
//  EpisodeListViewModel.swift
//  EpisodeInterface
//
//  Created by Kanghos on 2023/12/14.
//

import Foundation

import RxSwift
import RxCocoa

import Core
import EpisodeInterface

protocol EpisodeSearchDelegate: AnyObject {
  func presentItem(_ item: RMEpisode)
}

public final class EpisodeListViewModel: ViewModelType {
  private let useCase: FetchEpisodeUseCaseInterface

  var delegate: EpisodeSearchDelegate?

  init(useCase: FetchEpisodeUseCaseInterface) {
    self.useCase = useCase
  }

  public struct Input {
    let onAppear: Driver<Void>
    let buttonTap: Driver<IndexPath>
    let paging: Driver<Void>
  }

  public struct Output {
    let route: Disposable
    let items: Driver<[RMEpisode]>
    let hasNextPage: Driver<Bool>
  }
}

extension EpisodeListViewModel {
  public func transform(input: Input) -> Output {
    let store = BehaviorRelay<RMEpisodeInfo?>(value: nil)
    let loadedList = BehaviorRelay<[RMEpisode]>(value: [])

    let onAppear = input.onAppear
      .withLatestFrom(loadedList.asDriver())
      .filter { $0.isEmpty }
      .map { _ in }

    let pagingTrigger = input.paging
      .skip(1)
      .debounce(.milliseconds(300))
      .debug("Paging Trigger")

    let addedList = Driver.merge(pagingTrigger, onAppear)
      .withLatestFrom(store.asDriver())
      .asObservable()
      .flatMapLatest(weak: self) { owner, currentStore -> Observable<RMEpisodeInfo> in
        guard let currentStore = currentStore else {
          return owner.useCase.fetchAllEpisodes(page: 1)
        }
        guard let nextPage = currentStore.info.nextPagenumber else {
          return .empty()
        }
        return owner.useCase.fetchAllEpisodes(page: nextPage)
      }
      .asDriver(onErrorDriveWith: .empty())
      .map { info -> [RMEpisode] in
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
      items: addedList,
      hasNextPage: hasNextPage
    )
  }
}
