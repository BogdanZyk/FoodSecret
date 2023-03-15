//
//  HomeView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @State private var showCalendarView: Bool = false
    
    @FetchRequest(fetchRequest: FoodEntity.fetchForDate(), animation: .default)
    var foods: FetchedResults<FoodEntity>
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16){
                    summarySection
                    mealsSection
                }
                .padding(.horizontal)
            }
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    calengarButton
                }
            }
            .sheet(isPresented: $showCalendarView) {
                Text("Calendar")
            }
            .navigationDestination(isPresented: $homeVM.showAddFoodView) {
                AddFoodView(forType: homeVM.selectedMealType)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, dev.viewContext)
    }
}


extension HomeView{
    
    private var summarySection: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
            VStack {
                Text("Summary")
                Symmary(foods: foods)
            }
        }
        .frame(height: 200)
        .padding(.top)
    }
    
    
    private var mealsSection: some View{
        MealsSectionView(foods: foods, homeVM: homeVM)
    }
    
    
    private var calengarButton: some View{
        Button {
            showCalendarView.toggle()
        } label: {
            Image(systemName: "calendar")
        }
        .buttonStyle(.plain)
    }
}

struct Symmary: View{
    var foods: FetchedResults<FoodEntity>
    var body: some View{
        VStack {
            Text(foods.compactMap({$0.calories}).reduce(0, +).toCalories)
        }
    }
}



