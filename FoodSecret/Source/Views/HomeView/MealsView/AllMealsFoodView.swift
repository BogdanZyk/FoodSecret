//
//  AllMealsFoodView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct AllMealsFoodView: View {
    @EnvironmentObject var rootVM: RootViewModel
    var body: some View {
        List {
            ForEach(MealType.allCases, id: \.self){type in
                Section {
                    ForEach(rootVM.foodForMeals(type)){food in
                        NavigationLink {
                            DetailsProductView(food.foodNameEditable, foodEntity: food, mealType: type)
                        } label: {
                            MealFoodRowView(food: food, onDelete: rootVM.removeFood)
                        }
                    }
                } header: {
                    HStack{
                        Text(type.title)
                        Spacer()
                        Text("\(type.getTotalCallForType(with: rootVM.foods).toCalories)")
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Meals")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AllMealsFoodView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AllMealsFoodView()
                .environmentObject(RootViewModel(mainContext: dev.viewContext))
        }
    }
}



