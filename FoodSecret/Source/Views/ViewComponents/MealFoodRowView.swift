//
//  MealFoodRowView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct MealFoodRowView: View {
    let food: FoodEntity
    let onDelete: (FoodEntity) -> ()
    var body: some View {
        HStack(spacing: 10){
            NukeLazyImage(strUrl: food.image)
                .frame(width: 45, height: 45)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 0) {
                Text(food.foodNameEditable.capitalized)
                    .font(.headline)
                Text(food.weight.toWeight)
                    .font(.callout)
            }
            Spacer()
            Text(food.represCalories)
                .font(.callout)
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
               onDelete(food)
            } label: {
                Image(systemName: "trash")
            }
        }
    }
}

struct FoodRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            MealFoodRowView(food: dev.simpleFoods[0], onDelete: {_ in})
        }
        
        .listStyle(.plain)
    }
}
