//
//  UserHalfInfo.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import Foundation

struct UserHalfInfo: Codable, Equatable{
  
    
    
    var weight: Double
    var gender: Gender
    var age: Int
    var height: Double
    var activityLevel: ActivityLevel
    var goal: GoalType
    var macronutrients: Macronutrients = .init()
    var waterInfo = WaterInfo()
    
    enum Gender: String, Codable, CaseIterable{
        case male, female
    }
    
    enum ActivityLevel: Double, Codable, CaseIterable{
        case low = 1.2
        case medium = 1.5
        case hight = 1.7
        
        var title: String{
            switch self{
            case .low: return "Low"
            case .medium: return "Medium"
            case .hight: return "Hight"
            }
        }
    }
    
    enum GoalType: Double, Codable, CaseIterable{
        case maintain = 1.0
        case gain = 1.5
        case loseWeight = 0.9
        
        var title: String{
            switch self {
            case .maintain: return "Maintain weight"
            case .loseWeight: return "Lose weight"
            case .gain: return "Gain weight"
            }
        }
    }
    
    var totalCallories: Double{
        var cal: Double = 0
        switch gender{
        case .male:
            cal = 88.3 + (13.4 * weight) + (4.8 * height) - (5.7 * Double(age))
        case .female:
            cal = 447.6 + (9.2 * weight) + (3.1 * height) - (4.3 * Double(age))
        }
        
       return (cal * activityLevel.rawValue) * goal.rawValue
    }
    
    var macronutrientsInGramm: (protein: Int, carb: Int, fat: Int){
        macronutrients.calcMacronutrientsInGramm(totalCallories)
    }
    
    func totalCalloriesForType(for type: MealType) -> Double{
        totalCallories * type.calDistributionPersent
    }
    
    
    static func == (lhs: UserHalfInfo, rhs: UserHalfInfo) -> Bool {
        lhs.totalCallories == rhs.totalCallories
    }
}


struct Macronutrients: Codable{
    var persentProtein: Double = 0.2
    var persentFat: Double = 0.3
    var persentCarb: Double = 0.5
    
    func calcMacronutrientsInGramm(_ callories: Double) -> (protein: Int, carb: Int, fat: Int){
        let protein = Int(callories * persentProtein) / 4
        let carb = Int(callories * persentCarb) / 4
        let fat = Int(callories * persentFat) / 9
        
        return (protein, carb, fat)
    }
}

struct WaterInfo: Codable{
    
    var totalValue: Double = 2.0
    
    var glassesCount: Int{
        Int(totalValue / 0.25)
    }
}
