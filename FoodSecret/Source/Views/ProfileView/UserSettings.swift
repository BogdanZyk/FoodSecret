//
//  UserSettings.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import Foundation

class UserSettings {
    
    struct Config {
        static let userHalfInfokey = "com.FoodSecret.userHalfInfo"
    }
    
    struct HalfInfo {

        static var info: UserHalfInfo = {
            guard let info: UserHalfInfo = UserDefaults(suiteName: AppGroup.gropKey.rawValue)?.loadObject(key: Config.userHalfInfokey) else {
                return .init(weight: 0, gender: .male, age: 0, height: 0, activityLevel: .low, goal: .maintain)
            }
            return info
        }(){
            didSet{
                UserDefaults(suiteName: AppGroup.gropKey.rawValue)?.saveObject(info, key: Config.userHalfInfokey)
            }
        }
    }
}
