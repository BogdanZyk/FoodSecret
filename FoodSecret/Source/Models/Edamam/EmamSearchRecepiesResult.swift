//
//  EmamSearchRecepiesResult.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 22.03.2023.
//

import Foundation


// MARK: - EmamSearchRecepiesResult
struct EdamamSearchRecepiesResult: Codable {
    let hits: [Hit]


}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe

    enum CodingKeys: String, CodingKey {
        case recipe
    }
}


// MARK: - Recipe
struct Recipe: Codable {
    let uri, label, image: String
    let images: Images?
    let source, url, shareAs: String?
    let yield: Int?
    let dietLabels, healthLabels, cautions, ingredientLines: [String?]
    let ingredients: [Ingredient]
    let calories: Double?
    let totalWeight: Double?
    let cuisineType, mealType, dishType: [String?]
    let externalId: String?


}


// MARK: - Images
struct Images: Codable {
    let thumbnail, small, regular, large: ResepiesImage?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

// MARK: - Large
struct ResepiesImage: Codable {
    let url: String
    let width, height: Int
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String?
    let quantity: Double?
    let measure, food: String?
    let weight: Double?
    let foodId: String?

}
