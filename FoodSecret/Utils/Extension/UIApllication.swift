//
//  UIApllication.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 19.03.2023.
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
}
