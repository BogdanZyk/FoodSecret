//
//  AddFoodView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct AddFoodView: View {
    let forType: MealType
    var body: some View {
        VStack{
            
        }
        .navigationTitle("Add \(forType.title)")
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(forType: .dinner)
    }
}
