//
//  HomeView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var rootVM: RootViewModel
    @State private var showCalendarView: Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 32){
                summarySection
                mealsSection
                waterSectionView
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .navigationTitle(rootVM.selectedDate.dayDifferenceStr)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                calengarButton
            }
        }
        .sheet(isPresented: $showCalendarView) {
            DatePickerSheetView()
                .environmentObject(rootVM)
        }
        .navigationDestination(isPresented: $rootVM.showAddFoodView) {
            SearchFoodView(forType: rootVM.selectedMealType)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RootViewModel(mainContext: dev.viewContext))
    }
}


extension HomeView{
    
    private var summarySection: some View{
        HomeSymmaryView(foods: rootVM.foods)
    }
    
    
    private var mealsSection: some View{
        MealsSectionView()
    }
    
    private var waterSectionView: some View{
        WaterSectionView()
    }
    
    private var calengarButton: some View{
        Button {
            showCalendarView.toggle()
        } label: {
            Image(systemName: "calendar")
        }
    }
}





