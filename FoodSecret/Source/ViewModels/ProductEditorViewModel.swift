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
    @Published var pickerType: ImagePickerType = .camera
    @Published var showPicker: Bool = false
    @Published var imagesData: [UIImageData] = []
    
    var isDisabledButton: Bool{
        customProduct.name.isEmpty && customProduct.callories.isZero
    }
    
    func createFood(mealType: MealType) -> Food{
        let imageId = createImageIfNeeded()
        return Food(foodName: customProduct.name, servingWeightGrams: Int(customProduct.weight), nfCalories: customProduct.callories, nfTotalFat: customProduct.fats, nfTotalCarbohydrate: customProduct.carbohydrate, nfSugars: 0, nfProtein: customProduct.protein, photo: .init(thumb: imageId), claims: [])
    }
    
    private func createImageIfNeeded() -> String{
        guard let image = imagesData.first?.image, let id = imagesData.first?.id else {
            return ""
        }
        FileManager().saveImage(with: id, image: image)
        return id
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
