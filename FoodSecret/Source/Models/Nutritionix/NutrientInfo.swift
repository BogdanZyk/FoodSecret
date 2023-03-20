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
    let servingWeightGrams: Int?
    let nfCalories, nfTotalFat: Double?
    let nfTotalCarbohydrate: Double?
    let nfSugars, nfProtein: Double?
    let photo: Photo
    let claims: [String]
    
    enum CodingKeys: String, CodingKey {
        
        case foodName = "food_name"
        case servingWeightGrams = "serving_weight_grams"
        case nfCalories = "nf_calories"
        case nfTotalFat = "nf_total_fat"
        case nfTotalCarbohydrate = "nf_total_carbohydrate"
        case nfSugars = "nf_sugars"
        case nfProtein = "nf_protein"
        case photo, claims
    }
    
    var clamsString: String{
        claims.joined(separator: ", ")
    }
    
    var freindlyFoodName: String{
        (foodName ?? "no name").capitalized
    }
    
    var nutritionDataForPer100Gramm: NutritionData{
        let weightFactor = 100.0 / Double(servingWeightGrams ?? 1)
        return calcNutritionData(weightFactor: weightFactor)
    }
    
    func calculeteNutritionData(for weight: Double) -> NutritionData{
        let weightFactor = weight / 100.0
        let dataForPer100Gramm = nutritionDataForPer100Gramm
        return .init(cal: dataForPer100Gramm.cal * weightFactor,
                     fat: dataForPer100Gramm.fat * weightFactor,
                     carb: dataForPer100Gramm.carb * weightFactor,
                     protein: dataForPer100Gramm.protein * weightFactor,
                     sugar: dataForPer100Gramm.sugar * weightFactor)
    }
    
    private func calcNutritionData(weightFactor: Double) -> NutritionData{
        let cal = (nfCalories ?? 0) * weightFactor
        let fat = (nfTotalFat ?? 0) * weightFactor
        let carb = (nfTotalCarbohydrate ?? 0) * weightFactor
        let protein = (nfProtein ?? 0) * weightFactor
        let sugar = (nfSugars ?? 0) * weightFactor
        return .init(cal: cal, fat: fat, carb: carb, protein: protein, sugar: sugar)
    }
    
    
    
    struct NutritionData{
        var cal: Double
        var fat: Double
        var carb: Double
        var protein: Double
        var sugar: Double
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


