//
//  MealsDetailsView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct MealsDetailsView: View {
    @EnvironmentObject var rootVM: RootViewModel
    let viewType: MealType
    var foods: [FoodEntity]{
        rootVM.foodForMeals(viewType)
    }
    var body: some View {
        List{
            symmarySection
                .listRowSeparator(.hidden, edges: .all)
            
            ForEach(foods){ food in
                NavigationLink {
                    DetailsProductView(food.foodNameEditable, foodEntity: food, mealType: viewType)
                } label: {
                    MealFoodRowView(food: food, onDelete: rootVM.removeFood)
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
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
        .environmentObject(RootViewModel(mainContext: dev.viewContext))
    }
}

 
extension MealsDetailsView{
    @ViewBuilder
    private var symmarySection: some View{
        let data = Helper.symmaryNutritionDataString(for: foods)
        HStack{
            ProductNutrionLabel(title: data.cal, subtitle: "Calories")
            ProductNutrionLabel(title: data.carbohyd, subtitle: "Carbs")
            ProductNutrionLabel(title: data.protein, subtitle: "Protein")
            ProductNutrionLabel(title: data.fat, subtitle: "Fat")
        }
        .padding(.bottom)
    }
    


    private var addProductButton: some View{
        
        NavigationLink {
            SearchFoodView(forType: viewType)
        } label: {
            Text("Add more")
                .font(.title3.weight(.medium))
                .foregroundColor(.white)
                .padding()
                .hCenter()
                .background(Color.accentColor, in: Capsule())
        } .padding()
    }
}


struct ProductNutrionLabel: View{
    let title: String
    let subtitle: String
    var body: some View{
        VStack{
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.callout)
        }
        .hCenter()
    }
}
