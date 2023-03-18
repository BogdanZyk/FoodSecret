//
//  ProductEditorViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import Foundation
import CoreData

class ProductEditorViewModel: ObservableObject{
    
    
    @Published var customProduct = CustomProduct()
    
    
    var isDisabledButton: Bool{
        customProduct.name.isEmpty && customProduct.callories.isZero
    }
    
    func createFood(mealType: MealType) -> Food{
        return Food(foodName: customProduct.name, servingQty: 0, servingWeightGrams: 0, nfCalories: customProduct.callories, nfTotalFat: customProduct.fats, nfTotalCarbohydrate: customProduct.carbohydrate, nfSugars: 0, nfProtein: customProduct.protein, photo: .init(thumb: ""), claims: [])
    }
    
    
    
    struct CustomProduct{
        var name: String = ""
        var callories: Double = .zero
        var protein: Double = .zero
        var fats: Double = .zero
        var carbohydrate: Double = .zero
        var weight: Double = .zero
    }
}
