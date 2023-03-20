//
//  MealFoodRowView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct MealFoodRowView: View {
    @ObservedObject var food: FoodEntity
    let onDelete: (FoodEntity) -> ()
    var body: some View {
        HStack(spacing: 10){
            image
            VStack(alignment: .leading, spacing: 2) {
                Text(food.foodNameEditable)
                    .font(.headline)
                Text(food.weight.toWeight)
                    .font(.callout)
                    .foregroundColor(.secondary)
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


extension MealFoodRowView{
    
    private var image: some View{
        Group{
            if food.userFood{
               Image(uiImage: food.uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }else{
                NukeLazyImage(strUrl: food.image)
            }
        }
        .frame(width: 45, height: 45)
        .cornerRadius(10)
    }
}
