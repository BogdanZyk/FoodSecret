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
    
    
    @Published var product: Food?
    let service = NutritionixService()
    var cancellable = Set<AnyCancellable>()
    
    
    init(_ productName: String){
        fetchInfo(for: productName)
    }
    
    func addProduct(_ context: NSManagedObjectContext, mealType: MealType){
        guard let product else { return }
        FoodEntity.create(for: product, mealType: mealType, count: 1, context: context)
        nc.post(name: .addNewProduct)
    }
    
    private func fetchInfo(for productName: String){
        service.getNutrientInfo(for: .init(query: productName))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished: break
                case .failure(let error):
                    print("Error load", error.localizedDescription)
                }
            } receiveValue: {[weak self] nutrientInfo in
                guard let self = self else {return}
                self.product = nutrientInfo.foods.first
            }
            .store(in: &cancellable)
    }

}
