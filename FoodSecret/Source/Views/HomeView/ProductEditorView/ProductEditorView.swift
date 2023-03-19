//
//  ProductEditorView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import SwiftUI

struct ProductEditorView: View {
    @EnvironmentObject var rootVM: RootViewModel
    @Environment(\.dismiss) var dismiss
    let mealType: MealType
    @StateObject private var viewModel = ProductEditorViewModel()
    @FocusState private var isFocused: Bool
    @State private var showConfirmationDialog: Bool = false
    var body: some View {
        VStack(spacing: 16){
            headerView
            productNameSection
            calloriesTextField
            nutritionInfoSection
            imageSection
            Spacer()
        }
        .padding()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                isFocused = true
            }
        }
        .imagePicker(pickerType: viewModel.pickerType, show: $viewModel.showPicker, imagesData: $viewModel.imagesData)
        .confirmationDialog("", isPresented: $showConfirmationDialog) {
            Button("Camera") {
                viewModel.pickerType = .camera
                viewModel.showPicker.toggle()
            }
            Button("Photo") {
                viewModel.pickerType = .photoLib
                viewModel.showPicker.toggle()
            }
        }
    }
}

struct ProductEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ProductEditorView(mealType: .breakfast)
            .environmentObject(RootViewModel(mainContext: dev.viewContext))
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
                let food = viewModel.createFood(mealType: mealType)
                rootVM.addFood(for: food, userFood: true, weight: viewModel.customProduct.weight, mealType: mealType)
                nc.post(name: .addNewProduct)
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
        HStack {
            NumberTextField(value: $viewModel.customProduct.callories, promt: "0g", label: "Calories")
            NumberTextField(value: $viewModel.customProduct.weight, promt: "0g", label: "Weight")
        }
        .padding(.vertical)
    }
   
    private var nutritionInfoSection: some View{
        HStack(spacing: 16){
            NumberTextField(value: $viewModel.customProduct.protein, promt: "0g", label: "Protein")
            NumberTextField(value: $viewModel.customProduct.carbohydrate, promt: "0g", label: "Carbs")
            NumberTextField(value: $viewModel.customProduct.fats, promt: "0g", label: "Fat")
        }
    }
    
    private var imageSection: some View{
        HStack {
            Button {
                showConfirmationDialog.toggle()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray5))
                    Image(systemName: "plus")
                        .font(.title3.bold())
                }
                .frame(width: 100, height: 100)
            }
            if let image = viewModel.imagesData.first?.image{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(12)
                    .onTapGesture {
                        viewModel.imagesData = []
                    }
            }
        }
        .hLeading()
    }
}


