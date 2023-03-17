//
//  AppGroup.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import Foundation


enum AppGroup: String {
  case gropKey = "group.com.bogdanZyk.FoodSecret"

  public var containerURL: URL {
    switch self {
    case .gropKey:
      return FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: self.rawValue)!
    }
  }
}
