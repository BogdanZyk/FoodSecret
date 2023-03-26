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
    @Published var error: NetworkError?
    @Published var searchState: SearchState = .waiting
    @Published var foods = [ProductSearchResult.Product]()
    @Published var query: String = ""
    @Published var showNewProductBanner: Bool = false
    
    init(){
        startSearchSubscription()
        setupNcPublisher()
    }
    
    private func setupNcPublisher(){
        nc.publisher(for: .addNewProduct)
            .delay(for: 0.5, scheduler: RunLoop.main)
            .sink {[weak self] _ in
                guard let self = self else {return}
                self.showNewProductBanner.toggle()
            }
            .store(in: &cancellable)
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
            .sink {[weak self] response in
                guard let self = self else {return}
                if let error = response.error{
                    self.error = error
                    self.searchState = .empty
                    print(error)
                }else{
                    guard let foods = response.value.map({$0.common + $0.branded}) else {
                        self.searchState = .empty
                        return
                    }
                    self.searchState = foods.isEmpty ? .empty : .load
                    self.foods = foods
                }
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

