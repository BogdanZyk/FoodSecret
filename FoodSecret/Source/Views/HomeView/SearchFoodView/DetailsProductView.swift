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
    @State private var selectedMealtype: MealType
    let mealType: MealType
    private var isUpdateView: Bool
    
    init(_ productName: String, foodEntity: FoodEntity? = nil, mealType: MealType){
        self.isUpdateView = foodEntity != nil
        self.mealType = mealType
        self._selectedMealtype = State(wrappedValue: mealType)
        _viewModel = StateObject(wrappedValue: DetailsProductViewModel(productName, foodEntity: foodEntity))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 16) {
                if let food = viewModel.product{
                    image(food)
                    VStack(alignment: .leading, spacing: 10){
                        Text(food.freindlyFoodName)
                            .font(.title2.bold())
                        usedNutritionInfoSection(food)
                        clamsAndNutritionProductData(food)
                        
                    }
                    .padding([.horizontal, .bottom])
                }else{
                    ProgressView()
                        .padding(.top, 50)
                }
            }
        }
        .onTapGesture(perform: UIApplication.shared.endEditing)
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
            if viewModel.product != nil{
                bottomBarView
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                menuMealType
            }
        }
    }
}

struct DetailsProductView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailsProductView("egg", mealType: .breakfast)
            
        }
        .environmentObject(RootViewModel(mainContext: dev.viewContext))
    }
}

extension DetailsProductView{
    
    private func image(_ food: Food) -> some View{
        Group{
            if viewModel.foodEntity?.userFood ?? false, let image = viewModel.foodEntity?.uiImage{
                Image(uiImage: image)
                     .resizable()
                     .aspectRatio(contentMode: .fill)
            }else{
                NukeLazyImage(strUrl: food.photo.thumb, resizeHeight: 500, resizingMode: .fill, loadPriority: .high)
            }
        }
        .frame(height: 200)
        .clipped()
    }
    
    
    @ViewBuilder
    private func usedNutritionInfoSection(_ food: Food) -> some View{
        let usedNutrienData = food.calculeteNutritionData(for: viewModel.weight)
        HStack{
            ProductNutrionLabel(title: usedNutrienData.cal.toCalories, subtitle: "Calories")
            ProductNutrionLabel(title: usedNutrienData.carb.toWeight, subtitle: "Carbs")
            ProductNutrionLabel(title: usedNutrienData.protein.toWeight, subtitle: "Protein")
            ProductNutrionLabel(title: usedNutrienData.fat.toWeight, subtitle: "Fat")
        }
        .padding()
        .background(Color.secondaryBlue.opacity(0.2), in: RoundedRectangle(cornerRadius: 12))
        .padding(.vertical, 16)
    }
    
    
    private var bottomBarView: some View{
        HStack(spacing: 15) {
            HStack {
                NumberTextField(value: $viewModel.weight, promt: "weight", label: nil, withDivider: false)
                Text("g")
            }
            .padding()
            .frame(width: 100)
            .background(Color(.systemGray4), in: RoundedRectangle(cornerRadius: 12))
            
            Button {
                if let food = viewModel.product{
                    if let foodEntity = viewModel.foodEntity, isUpdateView{
                        rootVM.updateFood(for: foodEntity, weight: viewModel.weight, food: food, mealType: selectedMealtype)
                    }else{
                        rootVM.addFood(for: food, userFood: false, weight: viewModel.weight, mealType: mealType)
                        nc.post(name: .addNewProduct)
                    }
                    dismiss()
                }
                
            } label: {
                Text(isUpdateView ? "Save" : "Add food")
                   .font(.title3.weight(.bold))
            }
            .buttonStyle(CapsuleButton())
            .disabled(viewModel.weight <= 0)
        }
        .padding()
        .background(Color(.systemGray5))
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func clamsAndNutritionProductData(_ food: Food) -> some View{
        let nutritionData = food.nutritionDataForPer100Gramm
        VStack(alignment: .leading, spacing: 16) {
            
            if !food.clamsString.isEmpty{
                VStack(alignment: .leading, spacing: 16) {
                    Text("Clams")
                        .font(.headline)
                    Text(food.clamsString)
                        .font(.subheadline)
                }
            }
            
            Text("Nutrition per 100 gramm")
                .font(.headline)
            VStack(spacing: 10){
                nutritionRowView("Calories", nutritionData.cal.toCalories)
                nutritionRowView("Protein", nutritionData.protein.toWeight)
                nutritionRowView("Fats", nutritionData.fat.toWeight)
                nutritionRowView("Carbs", nutritionData.carb.toWeight)
                nutritionRowView("Sugar", nutritionData.sugar.toWeight)
            }
        }
    }
    
    private func nutritionRowView(_ title: String, _ value: String) -> some View{
        HStack{
            Text(title)
            Spacer()
            Text(value)
        }
        .font(.subheadline.bold())
    }
    
    @ViewBuilder
    private var menuMealType: some View{
        if isUpdateView{
            
            Picker(selection: $selectedMealtype) {
                ForEach(MealType.allCases, id: \.self) { type in
                    Text("\(type.emoji) \(type.title)")
                        .tag(type)
                    
                }
            } label: {
                Text("\(selectedMealtype.emoji) \(selectedMealtype.title)")
                    .font(.headline)
            }
            .tint(.primaryFont)
            .pickerStyle(.menu)
            .padding(.trailing, getRect().width / 3)
        }else{
            Text("\(selectedMealtype.emoji) \(selectedMealtype.title)")
                .font(.headline)
        }
    }
}



