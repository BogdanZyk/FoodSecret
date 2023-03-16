//
//  ProductSearchResult.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import Foundation

// MARK: - SearchInstant
struct ProductSearchResult: Codable {
    var common: [Product]
    var branded: [Product]
}

extension ProductSearchResult{
    struct Product: Codable, Identifiable{
        let foodName: String?
        let photo: Photo
        
        var id: String{
            (foodName ?? "") + photo.thumb
        }
        
        enum CodingKeys: String, CodingKey {
            case foodName = "food_name"
            case photo
        }
    }
}






