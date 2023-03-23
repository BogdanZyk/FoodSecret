//
//  RecepiesListViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation
import Combine

class RecepiesListViewModel: ObservableObject{
    
    @Published var error: Error?
    @Published var recepies = [Recipe]()
    @Published var showLoader: Bool = false
    let servece = EdamamAPIService()
    var cancellable = Set<AnyCancellable>()
    
    
    init(type: (any EdamamQueryTypeProtocol)?){
        fetch(type)
    }
    
    func fetch(_ type: (any EdamamQueryTypeProtocol)?){
        guard let type else { return }
        self.showLoader = true
        let query = EdamamSearchQuery(categories: [type])
        servece.searchRecepies(searchQuery: query)
            .receive(on: DispatchQueue.main)
            .map({$0.hits.map({$0.recipe})})
            .sink {[weak self] completion in
                guard let self = self else {return}
                switch completion{
                case .finished:
                    self.showLoader = false
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: {[weak self] recipies in
                guard let self = self else {return}
                self.recepies = recipies
            }
            .store(in: &cancellable)
    }
}
