//
//  MealsDetailsView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct MealsDetailsView: View {
    let viewType: MealType
    @FetchRequest(fetchRequest: FoodEntity.fetchForDate(), animation: .default)
    var foods: FetchedResults<FoodEntity>
    var body: some View {
        List{
            ForEach(foods.filter({$0.mealType == viewType})){food in
                NavigationLink {
                    UpdateView(item: food)
                } label: {
                    MealFoodRowView(food: food)
                }
            }
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewType.title)
                    .font(.title3.weight(.medium))
            }
        }
    }
}

struct MealsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MealsDetailsView(viewType: .lunch)
        }
        .environment(\.managedObjectContext, dev.viewContext)
    }
}

 
extension MealsDetailsView{
    
}
