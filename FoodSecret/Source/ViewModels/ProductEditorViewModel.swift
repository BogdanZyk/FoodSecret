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
    
    
    func addProduct(_ context: NSManagedObjectContext, mealType: MealType){
        let food = Food(foodName: customProduct.name, servingQty: 0, servingWeightGrams: 0, nfCalories: customProduct.callories, nfTotalFat: customProduct.fats, nfSaturatedFat: 0, nfTotalCarbohydrate: customProduct.carbohydrate, nfSugars: 0, nfProtein: customProduct.protein, photo: .init(thumb: ""), claims: [])
        FoodEntity.create(for: food, mealType: mealType, count: 1, context: context)
    }
    
    
    
    struct CustomProduct{
        var name: String = ""
        var callories: Double = .zero
        var protein: Double = .zero
        var fats: Double = .zero
        var carbohydrate: Double = .zero
    }
}
