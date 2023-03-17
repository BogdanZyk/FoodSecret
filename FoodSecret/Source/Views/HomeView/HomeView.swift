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
            VStack(spacing: 16){
                summarySection
                mealsSection
            }
            .padding(.horizontal)
        }
        .navigationTitle(rootVM.selectedDate.dayDifferenceStr)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                calengarButton
            }
        }
        .sheet(isPresented: $showCalendarView) {
            DatePicker("Select date", selection: $rootVM.selectedDate, displayedComponents: .date)
                .onChange(of: rootVM.selectedDate) { newValue in
                    showCalendarView = false
                    rootVM.fetchCoreData()
                }
                .datePickerStyle(.graphical)
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
    
    
    private var calengarButton: some View{
        Button {
            showCalendarView.toggle()
        } label: {
            Image(systemName: "calendar")
        }
    }
}





