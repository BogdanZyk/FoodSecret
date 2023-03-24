//
//  SearchFoodView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct SearchFoodView: View {
    @StateObject var viewModel = SearhFoodViewModel()
    @State private var sheetItem: SheetType?
    let forType: MealType
   
    var body: some View {
        ZStack {
            switch viewModel.searchState{
            case .loading:
                ProgressView()
            case .load:
                listSection
            case .empty:
                emptyView
            case .waiting:
                waitView
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.searchState)
        .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always), prompt: .none)
        .navigationTitle("\(forType.title)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                createProductButton
            }
        }
        .sheet(item: $sheetItem) { type in
            switch type{
            case .add:
                ProductEditorView(mealType: forType)
            case .select(let name):
                DetailsProductView(name, mealType: forType)
            }
        }
        .overlay {
            productAddedBunner
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
                Button {
                    if let name = food.foodName{
                        sheetItem = .select(name)
                    }
                } label: {
                    HStack{
                        NukeLazyImage(strUrl: food.photo.thumb, resizeHeight: 100, resizingMode: .aspectFit, loadPriority: .normal)
                            .frame(width: 40, height: 40)
                            .cornerRadius(12)
                        Text(food.foodName?.capitalized ?? "no name")
                            .lineLimit(1)
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    private var emptyView: some View{
        VStack(spacing: 20){
            Text("Nothing was found.\nChange the search filter or create your own product.")
                .multilineTextAlignment(.center)
                .font(.title3.bold())
           createButton
        }
    }
    
    private var waitView: some View{
        VStack(spacing: 20) {
            Text("Find a product, or create your own")
                .font(.title3.bold())
            createButton
        }
    }
    
    private var createProductButton: some View{
        Button {
            sheetItem = .add
        } label: {
            Image(systemName: "plus.circle.fill")
        }
        .foregroundColor(Color(uiColor: .systemCyan))
    }
    
    
    private var createButton: some View{
        Button {
            sheetItem = .add
        } label: {
            Text("Create new product")
                .font(.title3.weight(.medium))
        }
    }
    
    private var productAddedBunner: some View{
        Group{
            if viewModel.showNewProductBanner{
                VStack{
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(.systemGreen))
                    Text("Food item has been saved!")
                        .font(.title3.bold())
                }
                .padding()
                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        viewModel.showNewProductBanner = false
                    }
                }
            }
        }
        .animation(.easeInOut, value: viewModel.showNewProductBanner)
    }
}

extension SearchFoodView{
    enum SheetType: Identifiable{
        case add
        case select(String)
        
        var id: Int{
            switch self{
            case .add: return 0
            case .select(_): return 1
            }
        }
    }
}
