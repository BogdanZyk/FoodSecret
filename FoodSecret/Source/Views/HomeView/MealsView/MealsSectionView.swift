//
//  MealsSectionView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct MealsSectionView: View {
    @Environment(\.colorScheme) private var colorScheme
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
            VStack(alignment: .leading){
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
        let totalCall = totalCall(foodsForType)
        NavigationLink(value: type) {
            HStack(spacing: 16) {
                ProgressCircleView(persentage: totalCall.calculatePercentage(for: 775), size: .small, circleOutline: .green, circleTrack: .gray.opacity(0.3)) {
                    Text(type.emoji)
                        .font(.system(size: 25))
                }
                VStack(alignment: .leading) {
                    Text(type.title)
                        .font(.headline)
                    Text("\(Int(totalCall))/775 cal")
                        .font(.caption.weight(.light))
                }
                Spacer()
                Button {
                    rootVM.showAddFoodView(type)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .foregroundColor(Color(uiColor: .systemTeal))
                }
            }
            .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
    
    private func totalCall(_ foods: [FoodEntity]) -> Double{
        foods.compactMap({$0.calories}).reduce(0, +)
    }
}
