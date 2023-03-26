//
//  RecepiesListView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import SwiftUI

struct RecepiesListView<T: EdamamQueryTypeProtocol> : View where T.AllCases: RandomAccessCollection {
    @StateObject private var viewModel: RecepiesListViewModel
    let types: T.Type
    @State var selectedType: T?
    
    init(types: T.Type, selectedType: T?) {
        self.types = types
        self._selectedType = State(wrappedValue: selectedType)
        self._viewModel = StateObject(wrappedValue: RecepiesListViewModel(type: selectedType))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            categoryHeader
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    if !viewModel.showLoader{
                        recepiesSection
                    }else{
                        ProgressView()
                            .padding(50)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(selectedType?.typeTitle ?? "type")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedType) { type in
            viewModel.fetch(type)
        }
        .animation(.easeInOut, value: viewModel.showLoader)
    }
}

struct RecepiesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecepiesListView(types: EdamamDishType.self, selectedType: .bread)
        }
    }
}

extension RecepiesListView{
    private var categoryHeader: some View{
        ReceptCategoriesView(selectedType: $selectedType, types: T.self, withOutAnimation: false, isNavLink: false)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    private var recepiesSection: some View{
        if !viewModel.recepies.isEmpty{
            ForEach(viewModel.recepies) { recept in
                NavigationLink {
                    ReceptDetailsView(recept: recept)
                } label: {
                    ReceptRowView(recept: recept)
                }
            }
        }else{
           Text("Empty result")
                .font(.title3.weight(.medium))
        }
        
    }
}
