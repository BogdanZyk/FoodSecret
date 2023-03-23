//
//  MainRecepiesView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import SwiftUI

struct MainRecepiesView: View {
    @StateObject var viewModel = RecepiesViewModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 32) {
                popularCategoriesSectionView
                calloriesCategorySectionView
                mealsTypeCategorySectionView
                dishTypeCategorySectionView
            }
            .padding()
        }
        .navigationTitle("Recipes")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct MainRecepiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainRecepiesView()
        }
    }
}

extension MainRecepiesView{
    private var popularCategoriesSectionView: some View{
        ReceptCategoriesView(selectedType: .constant(nil), label: "Popular categories", types: EdamamDietType.self, withOutAnimation: true)
    }
    
    private var calloriesCategorySectionView: some View{
        ReceptCategoriesView(selectedType:  .constant(nil), label: "Calorie counter", types: EdamamCaloriesType.self, viewType: .grid, withOutAnimation: true)
    }
    
    private var mealsTypeCategorySectionView: some View{
        ReceptCategoriesView(selectedType: .constant(nil), label: "Meals type", types: EdamamMealType.self, withOutAnimation: true)
    }
    
    private var dishTypeCategorySectionView: some View{
        ReceptCategoriesView(selectedType: .constant(nil), label: "Dish type", types: EdamamDishType.self, withOutAnimation: true)
    }
}
