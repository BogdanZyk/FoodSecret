//
//  RecepiesViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

class RecepiesViewModel: ObservableObject{
    
    @Published var query = EdamamSearchQuery()
    @Published var selectedType: (any EdamamQueryTypeProtocol)?
    @Published var show: Bool = false
}
