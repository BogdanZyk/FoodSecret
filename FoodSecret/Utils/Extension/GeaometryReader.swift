//
//  GeaometryReader.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 24.03.2023.
//

import Foundation
import SwiftUI


extension GeometryProxy {
    
    var offset: CGFloat {
        frame(in: .global).minY
    }
    var height: CGFloat {
        
        size.height + (offset > 0 ? offset : 0)
        
    }
    var verticalOffset: CGFloat{
        offset > 0 ? -offset : 0
    }
}
