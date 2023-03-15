//
//  MealsDetailsView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct MealsDetailsView: View {
    let viewType: MealType
    var foods: FetchedResults<FoodEntity>
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                ForEach(foods.filter({$0.mealType == viewType})){ food in
                    NavigationLink {
                        UpdateView(item: food)
                    } label: {
                        Text(food.foodNameEditable)
                    }
                }
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewType.title)
                    .font(.title3.weight(.medium))
            }
        }
//        .onAppear{
//            foods.nsPredicate = FoodEntity.mealPredicate(viewType)
//        }
    }
}

//struct MealsDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            MealsDetailsView(viewType: .dinner, foods: dev.viewContext.fetch(FoodEntity.fetchForDate()))
//        }
//    }
//}
