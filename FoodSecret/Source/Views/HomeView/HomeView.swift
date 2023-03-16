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
                SearchFoodView(forType: homeVM.selectedMealType)
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
        HomeSymmaryView(foods: foods)
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
    }
}

struct HomeSymmaryView: View{
    var foods: FetchedResults<FoodEntity>
    
    var summaryData: (cal: Double, carbohyd: Double, protein: Double, fat: Double){
        Helper.symmaryNutritionData(for: Array(foods))
    }
    
    var body: some View{
        VStack(spacing: 20) {
            ProgressCircleView(persentage: summaryData.cal.calculatePercentage(for: 4500), size: .large, animate: true, circleOutline: Color(UIColor.systemTeal), circleTrack: Color(UIColor.systemTeal).opacity(0.3)) {
                Text("")
            }
            .frame(width: 100)
            .padding(.top, 6)
            HStack(spacing: 10){
                lineProgress(summaryData.carbohyd, title: "Carbs", total: 315)
                lineProgress(summaryData.protein, title: "Protein", total: 315)
                lineProgress(summaryData.fat, title: "Fat", total: 315)
            }
           
        }
        .padding()
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
    }
}

extension HomeSymmaryView{
    
    
    private func lineProgress(_ value: Double, title: String, total: Int) -> some View{
        VStack(spacing: 6){
            Text(title)
                .font(.caption)
            LineProgressView(value: CGFloat(value.calculatePercentage(for: Double(total))), animate: true)
                .frame(height: 6)
            Text("\(Int(value))/\(total)")
                .font(.caption.weight(.medium))
        }
    }
    
}



