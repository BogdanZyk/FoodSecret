//
//  Double+ext.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import Foundation

extension Double{
    
    
    var friendlyString: String {
        String(format: "%.2f", self)
    }

    var numberOfWaterGlasses: Int{
        Int(self / 0.25)
    }
}
