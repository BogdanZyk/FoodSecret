//
//  ProductEditorView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import SwiftUI

struct ProductEditorView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    let mealType: MealType
    @StateObject private var viewModel = ProductEditorViewModel()
    @FocusState private var isFocused: Bool
    var body: some View {
        VStack(spacing: 16){
            headerView
            productNameSection
            calloriesTextField
            nutritionInfoSection
            Spacer()
        }
        .padding()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                isFocused = true
            }
        }
    }
}

struct ProductEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ProductEditorView(mealType: .breakfast)
    }
}


extension ProductEditorView{
    private var headerView: some View{
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.headline.bold())
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            Button {
                viewModel.addProduct(viewContext, mealType: mealType)
                dismiss()
            } label: {
                Text("Save")
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isDisabledButton)
        }
    }
    
    private var productNameSection: some View{
        VStack(alignment: .leading){
            Text("New product")
                .font(.headline.bold())
            TextField("Enter product name", text: $viewModel.customProduct.name)
                .font(.title2.weight(.medium))
                .focused($isFocused)
        }
    }
    
    private var calloriesTextField: some View{
        CustomTextField(value: $viewModel.customProduct.callories, promt: "0g", label: "Calories")
            .padding(.vertical)
    }
   
    private var nutritionInfoSection: some View{
        HStack(spacing: 16){
            CustomTextField(value: $viewModel.customProduct.protein, promt: "0g", label: "Protein")
            CustomTextField(value: $viewModel.customProduct.carbohydrate, promt: "0g", label: "Carbs")
            CustomTextField(value: $viewModel.customProduct.fats, promt: "0g", label: "Fat")
        }
    }
}

extension ProductEditorView{
    
    struct CustomTextField: View{
        @Binding var value: Double
        let promt: String
        let label: String
        let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
        
        var body: some View{
            VStack(alignment: .leading) {
                Text(label)
                    .font(.headline)
                TextField(promt, value: $value, formatter: formatter)
                    .font(.title3.weight(.medium))
                    .keyboardType(.decimalPad)
                Divider()
            }
        }
    }
    
}

