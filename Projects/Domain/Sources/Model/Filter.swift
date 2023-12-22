//
//  Filter.swift
//  Character
//
//  Created by Kanghos on 2023/12/18.
//

import Foundation
import CharacterInterface
import LocationInterface
import EpisodeInterface

public enum Filter {
  public enum Item {
    case name(String?)
    case type(String?)

    case gender(RMGender?)
    case status(RMCharacterStatus?)
    case species(String?)

    case dimension(String?)
    case episode(String?)

    public var hasOptions: Bool {
      options.isEmpty != true
    }

    public var options: [String] {
      switch self {
      case .name:
        return []
      case .type:
        return []
      case .gender:
        return RMGender.allCases.map { $0.rawValue }
      case .status:
        return RMCharacterStatus.allCases.map { $0.rawValue }
      case .species:
        return []
      case .dimension:
        return []
      case .episode:
        return []
      }
    }

    public var name: String {
      switch self {
      case .name:
        return "name"
      case .type:
        return "type"
      case .gender:
        return "gender"
      case .status:
        return "status"
      case .species:
        return "species"
      case .dimension:
        return "dimension"
      case .episode:
        return "episode"
      }
    }
    public var priority: Int {
      switch self {
      case .name:
        return 1
      case .type:
        return 2
      case .gender:
        return 3
      case .status:
        return 4
      case .species:
        return 5
      case .dimension:
        return 6
      case .episode:
        return 7
      }
    }
    public var value: String? {
      switch self {
      case .name(let value):
        return value
      case .type(let value):
        return value
      case .gender(let value):
        return value?.rawValue
      case .status(let value):
        return value?.rawValue
      case .species(let value):
        return value
      case .dimension(let value):
        return value
      case .episode(let value):
        return value
      }
    }
  }

  public struct State {
    public var list: [Item]

    public init(list: [Item]) {
      self.list = list
    }

    public func mutation(action: Action) -> State {
      let state = self

      switch action {
      case .initial:
        return state
      case .change(let item):
        return process(item, state: state)
      }
    }

    private func process(_ changeFilter: Item, state: State) -> State {
      var state = state

      state.list = changeList(list: state.list, newitem: changeFilter)

      return state
    }

    private func changeList(list: [Item], newitem: Item) -> [Item] {
      var list = list
      list.removeAll {
        $0.name == newitem.name
      }
      // TODO: state의 list와 list 값 차이 나는지 확인 value니까
      list.append(newitem)

      return list
    }
  }

  public enum Action {
    case initial
    case change(Item)
  }

  static func makeCharacterState() -> State {
    State(list: .makeCharacterFilter())
  }

  static func makeEpisodeState() -> State {
    State(list: .makeEpisodeFilter())
  }

  static func makeLocationState() -> State {
    State(list: .makeLocationFilter())
  }
}

public extension Array where Self.Element == Filter.Item {
  static func makeCharacterFilter() -> [Element] {
    [.name(nil), .gender(nil), .species(nil), .type(nil), .status(nil)]
  }

  static func makeLocationFilter() -> [Element] {
    [.name(nil), .type(nil), .dimension(nil)]
  }

  static func makeEpisodeFilter() -> [Element] {
    [.name(nil), .episode(nil)]
  }

  func toParameter() -> Dictionary<String, String?> {
    var parameterDict: [String: String?] = [:]
    for item in self {
      parameterDict[item.name] = item.value
    }
    return parameterDict
  }
}

extension Filter.Item: Equatable {
  public static func ==(lhs: Filter.Item, rhs: Filter.Item) -> Bool {
      return lhs.name == rhs.name
  }
}

