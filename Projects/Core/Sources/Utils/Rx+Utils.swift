//
//  Rx+Utils.swift
//  Core
//
//  Created by Kanghos on 2023/12/10.
//

import UIKit

import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }

    var viewWillAppear: ControlEvent<Bool> {
        let source = methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }

    var viewDidAppear: ControlEvent<Bool> {
        let source = methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}

public extension ObservableType {
  func flatMapLatest<A: AnyObject, O: ObservableType>(weak obj: A, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
    return flatMapLatest { [weak obj] value -> Observable<O.Element> in
      try obj.map { try selector($0, value).asObservable() } ?? .empty() }
  }
}
