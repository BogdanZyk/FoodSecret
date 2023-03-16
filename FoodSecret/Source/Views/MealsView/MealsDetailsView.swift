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
            symmarySection
                .listRowSeparator(.hidden, edges: .all)
            
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
        .overlay(alignment: .bottom) {
            addProductButton
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
    @ViewBuilder
    private var symmarySection: some View{
        let data = Helper.symmaryNutritionDataString(for: foods.filter({$0.mealType == viewType}))
        HStack{
            summaryLabel(data.cal, "Calories")
            summaryLabel(data.carbohyd, "Carbs")
            summaryLabel(data.protein, "Protein")
            summaryLabel(data.fat, "Fat")
        }
        .padding(.bottom)
    }
    
    private func summaryLabel(_ title: String, _ subtitle: String) -> some View{
        VStack{
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.callout)
        }
        .hCenter()
    }

    private var addProductButton: some View{
        
        NavigationLink {
            AddFoodView(forType: viewType)
        } label: {
            Text("Add more")
                .font(.title3.weight(.medium))
                .foregroundColor(.white)
                .padding()
                .hCenter()
                .background(Color.blue, in: Capsule())
        } .padding()
    }
}
