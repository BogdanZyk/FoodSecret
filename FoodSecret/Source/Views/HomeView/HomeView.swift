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
        let result = PersistenceController(inMemory: true)
        let viewContext = result.viewContext
        
        let food1 = FoodEntity(context: viewContext)
        food1.id = UUID()
        food1.foodName = "Eggs"
        food1.mealType = .breakfast
        food1.createAt = Date.now
        food1.calories = 125.5
        food1.image = "United"
        
        let food2 = FoodEntity(context: viewContext)
        food2.id = UUID()
        food2.foodName = "Cake"
        food2.mealType = .lunch
        food2.createAt = Date.now
        food2.calories = 120
        food2.image = "United"
        
       return HomeView()
            .environment(\.managedObjectContext, viewContext)
    }
}


extension HomeView{
    
    private var summarySection: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
               Text("Summary")
        }
        .frame(height: 200)
        .padding(.top)
    }
    
    
    private var mealsSection: some View{
        MealsSectionView(foods: Array(foods), homeVM: homeVM)
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
