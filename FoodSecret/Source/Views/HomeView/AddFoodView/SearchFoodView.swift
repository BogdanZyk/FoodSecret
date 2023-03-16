//
//  SearchFoodView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct SearchFoodView: View {
    @StateObject var viewModel = SearhFoodViewModel()
    let forType: MealType
    @State var showSheet: Bool = false
    var body: some View {
        ZStack {
            switch viewModel.searchState{
            case .loading:
                ProgressView()
            case .load:
                listSection
            case .empty:
                Text("Empty result")
            case .waiting:
                waitView
            }
        }
        .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always), prompt: .none)
        .navigationTitle("\(forType.title)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                createProductButton
            }
        }
        .sheet(isPresented: $showSheet) {
            Text("Sheet")
                .presentationDetents([.medium])
        }
    }
}

struct SearchFoodView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchFoodView(forType: .dinner)
        }
    }
}


extension SearchFoodView{
    
    private var listSection: some View{
        List{
            ForEach(viewModel.foods){food in
                HStack{
                    NukeLazyImage(strUrl: food.photo.thumb, resizeHeight: 100, resizingMode: .center, loadPriority: .normal)
                        .frame(width: 40, height: 40)
                        .cornerRadius(12)
                    Text(food.foodName ?? "non")
                        .lineLimit(1)
                        .font(.headline)
                }
            }
        }
        .listStyle(.plain)
    }
    
    
    private var waitView: some View{
        Text("Find a product, or create your own")
            .font(.title3.bold())
    }
    
    private var createProductButton: some View{
        Button {
            showSheet.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
        }
        .foregroundColor(Color(uiColor: .systemCyan))
    }
}
