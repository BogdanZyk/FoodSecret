//
//  DetailsProductView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import SwiftUI

struct DetailsProductView: View {
    @EnvironmentObject var rootVM: RootViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: DetailsProductViewModel
    let mealType: MealType
    init(_ productName: String, mealType: MealType){
        self.mealType = mealType
        _viewModel = StateObject(wrappedValue: DetailsProductViewModel(productName))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let food = viewModel.product{
                NukeLazyImage(strUrl: food.photo.thumb, resizeHeight: 400, resizingMode: .aspectFit, loadPriority: .high)
                    .frame(height: 200)
                VStack(alignment: .leading, spacing: 10){
                    Text(food.foodName ?? "non")
                        .font(.title2.bold())
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Clams")
                            .font(.headline)
                        Text(food.claims.joined(separator: ", "))
                            .font(.subheadline)
                    }
                    infoSection(food)
                       
                    addButtonView
                }
                .padding()
            }else{
                Spacer()
                ProgressView()
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct DetailsProductView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsProductView("eggo", mealType: .breakfast)
            .environmentObject(RootViewModel(mainContext: dev.viewContext))
    }
}

extension DetailsProductView{
    private func infoSection(_ food: Food) -> some View{
        HStack{
            ProductNutrionLabel(title: food.nfCalories?.toCalories ?? "0", subtitle: "Calories")
            ProductNutrionLabel(title: food.nfTotalCarbohydrate?.toWeight ?? "0", subtitle: "Carbs")
            ProductNutrionLabel(title: food.nfProtein?.toWeight ?? "0", subtitle: "Protein")
            ProductNutrionLabel(title: food.nfTotalFat?.toWeight ?? "0", subtitle: "Fat")
        }
        .padding(.vertical, 10)
    }
    
    
    private var addButtonView: some View{
        Button {
            if let food = viewModel.product{
                rootVM.addFood(for: food, userFood: false, mealType: mealType)
                nc.post(name: .addNewProduct)
                dismiss()
            }
        } label: {
            Text("Add food")
                .font(.title3.weight(.bold))
                .foregroundColor(.white)
                .padding()
                .hCenter()
                .background(Color.accentColor, in: Capsule())
        }
        .padding(.vertical, 10)
    }
}
