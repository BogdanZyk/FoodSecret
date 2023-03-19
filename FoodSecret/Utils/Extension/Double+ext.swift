//
//  Double+ext.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import Foundation

extension Double{
    
    
    var twoNumString: String {
        String(format: "%.1f", self)
    }
    
    var treeNumString: String{
        if self.truncatingRemainder(dividingBy: 1) == 0{
            return String(format: "%.0f", self)
        }else{
           return String(format: "%.2f", self)
        }
    }

    var numberOfWaterGlasses: Int{
        Int(self / 0.25)
    }
    
    func calculatePercentage(for total: Double) -> CGFloat{
        if self >= total {return 1}
        return self / total
    }
    
    var toCalories: String{
        "\(Int(self)) cal"
    }
    
    var toWeight: String{
        twoNumString + " g"
    }
}
