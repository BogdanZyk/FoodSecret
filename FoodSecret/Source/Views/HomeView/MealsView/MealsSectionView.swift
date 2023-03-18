//
//  MealsSectionView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct MealsSectionView: View {
    @EnvironmentObject var rootVM: RootViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text("Meals")
                    .font(.title3.bold())
                Spacer()
                NavigationLink {
                    AllMealsFoodView()
                } label: {
                    Text("More")
                        .font(.subheadline.weight(.medium))
                }
            }
            VStack(alignment: .leading, spacing: 12){
                ForEach(MealType.allCases, id: \.self){type in
                    rowView(type)
                    if type != .snack{
                        Divider()
                    }
                }
            }
            .padding(16)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
        }
        .navigationDestination(for: MealType.self) { type in
            MealsDetailsView(viewType: type)
        }
    }
}

struct MealsSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MealsSectionView()
            .environmentObject(RootViewModel(mainContext: dev.viewContext))
    }
}


extension MealsSectionView{
    
    @ViewBuilder
    private func rowView(_ type: MealType) -> some View{
        let foodsForType = rootVM.foodForMeals(type)
        let usedCal = totalCall(foodsForType)
        let totalCal = rootVM.halfInfo.totalCalloriesForType(for: type)
        NavigationLink(value: type) {
            HStack(spacing: 16) {
                ProgressCircleView(persentage: usedCal.calculatePercentage(for: totalCal), size: .small, circleOutline: .green, circleTrack: .gray.opacity(0.3)) {
                    Text(type.emoji)
                        .font(.system(size: 25))
                }
                VStack(alignment: .leading) {
                    Text(type.title)
                        .font(.headline)
                    Text("\(Int(usedCal)) / \(Int(totalCal)) cal")
                        .font(.caption.weight(.light))
                }
                Spacer()
                Button {
                    rootVM.showAddFoodView(type)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(Color(uiColor: .systemTeal))
                }
            }
            .padding(.vertical, 0)
            .foregroundColor(.primaryFont)
        }
    }
    
    private func totalCall(_ foods: [FoodEntity]) -> Double{
        foods.compactMap({$0.calories}).reduce(0, +)
    }
}
