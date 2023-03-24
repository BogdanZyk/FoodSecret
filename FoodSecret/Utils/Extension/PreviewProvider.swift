//
//  PreviewProvider.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import CoreData
import SwiftUI

extension PreviewProvider {
    
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    


    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    
    let contreller = PersistenceController(inMemory: true)
    
    var viewContext: NSManagedObjectContext {
        
         let viewContext = contreller.viewContext
         
        _ = simpleFoods
        
        return viewContext
     }
    
    var simpleFoods: [FoodEntity]{
        let viewContext = contreller.viewContext

        let food1 = FoodEntity(context: viewContext)
        food1.id = UUID()
        food1.foodName = "Eggs"
        food1.mealType = .breakfast
        food1.createAt = Date.now
        food1.calories = 125.5
        food1.image = "https://nix-tag-images.s3.amazonaws.com/538_thumb.jpg"
        
        let food2 = FoodEntity(context: viewContext)
        food2.id = UUID()
        food2.foodName = "Burger"
        food2.mealType = .snack
        food2.createAt = Date.now
        food2.calories = 545.4
        food2.image = "https://nix-tag-images.s3.amazonaws.com/3148_thumb.jpg"

        let food3 = FoodEntity(context: viewContext)
        food3.id = UUID()
        food3.foodName = "Cake"
        food3.mealType = .lunch
        food3.createAt = Date.now
        food3.calories = 120
        food3.image = "https://nix-tag-images.s3.amazonaws.com/611_thumb.jpg"

        return [food1, food2, food3]
    }
    
    

}
