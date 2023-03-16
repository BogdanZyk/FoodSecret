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


