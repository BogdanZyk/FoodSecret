//
//  EdamamQueryTypeProtocol.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import Foundation

protocol EdamamQueryTypeProtocol: CaseIterable, Hashable {
    

    var params: [String: String] { get }
    var emoji: String { get }
    var title: String { get }
    var typeTitle: String { get }
    
}


