//
//  ProfileViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published private(set) var halfInfo = UserSettings.HalfInfo.info
    
    
    
    func saveInfo(_ tempInfo: UserHalfInfo){
        UserSettings.HalfInfo.info = tempInfo
        halfInfo = tempInfo
    }
    
    func saveWater(_ water: WaterInfo){
        halfInfo.waterInfo = water
        UserSettings.HalfInfo.info = halfInfo
    }
}


