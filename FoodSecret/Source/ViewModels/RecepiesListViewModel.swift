//
//  RecepiesListViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import SwiftUI
import Combine

class RecepiesListViewModel: ObservableObject{
    
    @Published var error: NetworkError?
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
            .sink{ [weak self] response in
                guard let self = self else {return}
                if let error = response.error{
                    self.error = error
                }else{
                    if let recepies = response.value?.hits.compactMap({$0.recipe}){
                        self.recepies = recepies
                    }
                }
                self.showLoader = false
            }
            .store(in: &cancellable)
    }
}
