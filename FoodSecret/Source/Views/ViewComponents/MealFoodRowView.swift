//
//  MealFoodRowView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct MealFoodRowView: View {
    let food: FoodEntity
    var body: some View {
        HStack(spacing: 10){
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.5))
                .frame(width: 45, height: 45)
            Text(food.foodNameEditable)
                .font(.headline)
            Spacer()
            Text(food.represCalories)
                .font(.callout)
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                FoodEntity.delete(food)
            } label: {
                Image(systemName: "trash")
            }
        }
    }
}

struct FoodRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            MealFoodRowView(food: dev.simpleFoods[0])
        }
        
        .listStyle(.plain)
    }
}
