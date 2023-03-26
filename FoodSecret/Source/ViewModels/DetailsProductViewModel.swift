//
//  DetailsProductViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import Foundation
import Combine
import CoreData

class DetailsProductViewModel: ObservableObject{
    
    @Published var weight: Double = 100.0
    @Published var product: Food?
    @Published var error: NetworkError?
    let service = NutritionixService()
    var cancellable = Set<AnyCancellable>()
    var foodEntity: FoodEntity?
    
    init(_ productName: String, foodEntity: FoodEntity?){
        if let foodEntity{
            setProductformEntity(foodEntity)
            self.foodEntity = foodEntity
        }else{
            fetchInfo(for: productName)
        }
    }
    
    
    private func setProductformEntity(_ foodEntity: FoodEntity) {
        
        let food: Food = .init(foodName: foodEntity.foodNameEditable, servingWeightGrams: Int(foodEntity.weight), nfCalories: foodEntity.calories, nfTotalFat: foodEntity.fat, nfTotalCarbohydrate: foodEntity.carbohydrate, nfSugars: foodEntity.sugars, nfProtein: foodEntity.protein, photo: .init(thumb: foodEntity.image ?? ""), claims: foodEntity.clamsArray)
        weight = foodEntity.weight
        product = food
    }
    
    private func fetchInfo(for productName: String){
        service.getNutrientInfo(for: .init(query: productName))
            .receive(on: DispatchQueue.main)
            .sink {[weak self] response in
                guard let self = self else {return}
                if let error = response.error{
                    self.error = error
                }else{
                    self.product = response.value?.foods.first
                    self.weight = Double(self.product?.servingWeightGrams ?? 100)
                }
            }
            .store(in: &cancellable)
    }

}
