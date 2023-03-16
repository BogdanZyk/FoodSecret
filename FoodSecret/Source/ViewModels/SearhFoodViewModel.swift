//
//  SearhFoodViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import Foundation
import Combine

class SearhFoodViewModel: ObservableObject{
    
    
    let service = NutritionixService()
    var cancellable = Set<AnyCancellable>()
    @Published var searchState: SearchState = .waiting
    @Published var foods = [ProductSearchResult.Product]()
    @Published var query: String = ""
    
    init(){
        startSearchSubscription()
    }
    
    
    private func startSearchSubscription(){
        $query
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink {[weak self] query in
                guard let self = self else {return}
                if query.isEmpty{
                    self.searchState = .waiting
                }else{
                    self.search(query)
                }
            }
            .store(in: &cancellable)
    }
    
    
    private func search(_ query: String){
        searchState = .loading
        service.search(query)
            .map({$0.branded + $0.common})
            .sink { [weak self] completion in
                guard let self = self else {return}
                
                switch completion{
                case .finished: break
                case .failure(let error):
                    print("Error load", error.localizedDescription)
                    self.searchState = .empty
                }
            } receiveValue: {[weak self] foods in
                guard let self = self else {return}
                self.searchState = foods.isEmpty ? .empty : .load
                self.foods = foods
            }
            .store(in: &cancellable)
        
    }
}

extension SearhFoodViewModel{
    enum SearchState{
        case load
        case loading
        case empty
        case waiting
    }
}

