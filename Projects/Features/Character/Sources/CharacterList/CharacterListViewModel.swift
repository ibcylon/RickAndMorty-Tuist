//
//  CharacterListViewModel.swift
//  CharacterInterface
//
//  Created by Kanghos on 2023/11/27.
//

import Foundation

import RxSwift
import RxCocoa

import Core
import CharacterInterface

protocol CharacterSearchDelegate: AnyObject {
  func logout()
  func presentItem(item: RMCharacter)
}

public final class CharacterListViewModel: ViewModelType {
  private let useCase: FetchCharacterUseCaseInterface

  var delegate: CharacterSearchDelegate?

  init(useCase: FetchCharacterUseCaseInterface) {
    self.useCase = useCase
  }
  
  public struct Input {
    let onAppear: Driver<Void>
    let buttonTap: Driver<IndexPath>
    let paging: Driver<Void>
  }

  public struct Output {
    let route: Driver<Void>
    let characterArray: Driver<[RMCharacter]>
    let hasNextPage: Driver<Bool>
  }
}

extension CharacterListViewModel {
  public func transform(input: Input) -> Output {
    let store = BehaviorRelay<RMCharacterInfo?>(value: nil)
    let loadedList = BehaviorRelay<[RMCharacter]>(value: [])

    let onAppear = input.onAppear
      .withLatestFrom(loadedList.asDriver())
      .filter { $0.isEmpty }
      .map { _ in }
    let pagingTrigger = input.paging
      .throttle(.seconds(3), latest: false)

    let addedList = Driver.merge(pagingTrigger, onAppear)
      .withLatestFrom(store.asDriver())
      .asObservable()
      .flatMapLatest(weak: self) { owner, currentStore -> Observable<RMCharacterInfo> in
        guard let nextPage = currentStore?.info.nextPagenumber else {
          return owner.useCase.fetchAllCharacters(page: 1)
        }
        return owner.useCase.fetchAllCharacters(page: nextPage)
      }.asDriver(onErrorDriveWith: .empty())
      .map {
        store.accept($0)
        var mutable = loadedList.value
        mutable.append(contentsOf: $0.results)
        loadedList.accept(mutable)
        return $0.results
      }

    let route = input.buttonTap
      .withLatestFrom(loadedList.asDriver()) { indexPath, array in
        RMLogger.dataLogger.debug("\(indexPath)")
        RMLogger.dataLogger.debug("\(array.count)")
        return array[indexPath.item]
      }
      .do(onNext: { [weak self] item in
        self?.delegate?.presentItem(item: item)
      }).map { _ in }

    let hasNextPage = store
      .map { $0?.info.next == nil ? false : true }
      .asDriver(onErrorJustReturn: false)

    return Output(
      route: route,
      characterArray: addedList,
      hasNextPage: hasNextPage
    )
  }
}
