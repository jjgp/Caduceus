//
//  DKVL.swift
//  Caduceus
//
//  Created by Jason Prasad on 5/3/20.
//  Copyright © 2020 Jason Prasad. All rights reserved.
//

// MARK: - SwiftLint Disable
// swiftlint:disable force_cast

import Foundation

/// Dynamic Key Value Lookup
@dynamicMemberLookup
enum DKVL {
  case null
  case bool(Bool)
  case int(Int)
  case double(Double)
  case string(String)
  case array([Any])
  case dictionary([String: Any?])

  init?(_ value: Any?) {
    switch value {
    case is Int:
      self = .int(value as! Int)
    case is Bool:
      self = .bool(value as! Bool)
    case is Double:
      self = .double(value as! Double)
    case is String:
      self = .string(value as! String)
    case is [Any]:
      self = .array(value as! [Any])
    case is [String: Any]:
      self = .dictionary(value as! [String: Any?])
    default:
      return nil
    }
  }
}

extension DKVL {
  subscript(index: Int) -> DKVL? {
    guard case .array(let arr) = self else {
        return nil
    }
    return DKVL(arr[index])
  }

  subscript(key: String) -> DKVL? {
    return dictionaryValue(for: key)
  }

  subscript(dynamicMember member: String) -> DKVL? {
    return dictionaryValue(for: member)
  }

  private func dictionaryValue(for key: String) -> DKVL? {
    guard case let .dictionary(dict) = self else {
      return nil
    }
    if dict.keys.contains(key) {
      return DKVL(dict[key, default: nil]) ?? .null
    } else {
      return nil
    }
  }
}

extension DKVL {

  var isNull: Bool {
    if case .null = self {
      return true
    } else {
      return false
    }
  }

  var boolValue: Bool? {
    if case .bool(let bool) = self {
      return bool
    }
    return nil
  }

  var intValue: Int? {
    if case .int(let int) = self {
      return int
    }
    return nil
  }

  var doubleValue: Double? {
    if case .double(let double) = self {
      return double
    }
    return nil
  }

  var stringValue: String? {
    if case .string(let str) = self {
      return str
    }
    return nil
  }

  var arrayValue: [Any]? {
    if case .array(let arr) = self {
      return arr
    }
    return nil
  }

  var arrayOfDKVL: [DKVL]? {
    return arrayValue?.compactMap { DKVL($0) }
  }

  func array<T>() -> [T]? {
    return arrayValue?.compactMap { DKVL($0 as? T) as? T }
  }

  var dictionaryValue: [String: Any?]? {
    if case .dictionary(let dict) = self {
      return dict
    }
    return nil
  }

  var dictionaryOfDKVL: [String: DKVL]? {
    if let keysWithValues = dictionaryValue?.compactMap({ ($0, DKVL($1)) as? (String, DKVL) }) {
      return Dictionary(uniqueKeysWithValues: keysWithValues)
    }
    return nil
  }

  func dictionary<T>() -> [String: T]? {
    if let keysWithValues = dictionaryValue?.compactMap({ ($0, $1) as? (String, T) }) {
      return Dictionary(uniqueKeysWithValues: keysWithValues)
    }
    return nil
  }
}
