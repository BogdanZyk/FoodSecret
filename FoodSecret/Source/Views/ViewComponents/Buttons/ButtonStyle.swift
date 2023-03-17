//
//  ButtonStyle.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import Foundation
import SwiftUI


struct CapsuleButton: ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.weight(.medium))
            .foregroundColor(.white)
            .padding()
            .hCenter()
            .background(Color.accentColor, in: Capsule())
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
    
    
}
