//
//  NutrientInfo.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import Foundation

// MARK: - NutrientInfo
struct NutrientInfo: Codable {
    let foods: [Food]
}

// MARK: - Food
struct Food: Codable {
    
    let foodName: String?
    let servingQty: Int?
    let servingWeightGrams: Int?
    let nfCalories, nfTotalFat: Double?
    let nfTotalCarbohydrate: Double?
    let nfSugars, nfProtein: Double?
    let photo: Photo
    let claims: [String]
    
    enum CodingKeys: String, CodingKey {
        
        case foodName = "food_name"
        case servingQty = "serving_qty"
        case servingWeightGrams = "serving_weight_grams"
        case nfCalories = "nf_calories"
        case nfTotalFat = "nf_total_fat"
        case nfTotalCarbohydrate = "nf_total_carbohydrate"
        case nfSugars = "nf_sugars"
        case nfProtein = "nf_protein"
        case photo, claims
    }
    
    
    var nutritionDataForPer100Gramm: NutritionData{
        let weightFactor = Double(100 / (servingWeightGrams ?? 1))
        return calcNutritionData(weightFactor: weightFactor)
    }
    
    func calculeteNutritionData(for weight: Double) -> NutritionData{
        let weightFactor = Double(weight / 100)
        return calcNutritionData(weightFactor: weightFactor)
    }
    
    private func calcNutritionData(weightFactor: Double) -> NutritionData{
        let cal = (nfCalories ?? 0) * weightFactor
        let fat = (nfTotalFat ?? 0) * weightFactor
        let carb = (nfTotalCarbohydrate ?? 0) * weightFactor
        let protein = (nfProtein ?? 0) * weightFactor
        return .init(cal: cal, fat: fat, carb: carb, protein: protein)
    }
    
    
    
    struct NutritionData{
        var cal: Double
        var fat: Double
        var carb: Double
        var protein: Double
    }
}

struct NutrientParams: Codable{
    let query: String
    var claims: Bool = true
    var useBrandedFoods: Bool = true
    
    enum CodingKeys: String, CodingKey {
        case query, claims
        case useBrandedFoods = "use_branded_foods"
    }
}


struct Photo: Codable {
    var thumb: String
}


