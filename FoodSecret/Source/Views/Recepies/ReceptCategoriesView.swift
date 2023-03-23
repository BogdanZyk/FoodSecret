//
//  ReceptCategoriesView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import SwiftUI

struct ReceptCategoriesView<T: EdamamQueryTypeProtocol> : View where T.AllCases: RandomAccessCollection{
    @Namespace var namespace
    @Binding var selectedType: T?
    var label: String? = nil
    let types: T.Type
    var withLabel: Bool = true
    var viewType: ViewType = .hStack
    var withOutAnimation: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let label{
                Text(label)
                    .font(.headline.bold())
            }
            ScrollView(.horizontal, showsIndicators: false) {
                Group{
                    switch viewType{
                    case .hStack:
                        hsStackSection
                    case .grid:
                        grigSection
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, -16)
        }
        .animation(withOutAnimation ? nil : .easeIn(duration: 0.2), value: selectedType)
    }
}


struct ReceptCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        ReceptCategoriesView(selectedType: .constant(.balanced), label: "Title", types: EdamamDietType.self)
            .padding(.horizontal)
    }
}

extension ReceptCategoriesView{
    enum ViewType: Int{
        case grid, hStack
        
        var emojiFont: Font{
            switch self{
            case .grid: return .system(size: 35)
            case .hStack: return .title2
            }
        }
        
        var frameSize: CGFloat{
            switch self{
            case .grid: return 110
            case .hStack: return 75
            }
        }
        
        var titleFont: Font{
            switch self{
            case .grid: return .subheadline
            case .hStack: return .subheadline
            }
        }
    }
    
    
    private var hsStackSection: some View{
        LazyHStack{
            ForEach(types.allCases, id:\.self) { type in
                rowView(type)
            }
        }
        .frame(height: viewType.frameSize)
    }
    
    private var grigSection: some View{
        LazyHGrid(rows: [.init(.fixed(viewType.frameSize)), .init(.fixed(viewType.frameSize))], alignment: .center, spacing: 10) {
            ForEach(types.allCases, id:\.self) { type in
                rowView(type)
            }
        }
        .frame(height: viewType.frameSize * 2 + 20)
    }
    
    private func rowView(_ type: T) -> some View{
        ZStack {
            if selectedType == type {
                Color.accentColor.opacity(0.6)
                    .matchedGeometryEffect(id: "type", in: namespace)
            }else{
                Color(.systemGray6)
            }
            VStack(spacing: 5) {
                Text(type.emoji)
                    .font(viewType.emojiFont)
                if withLabel{
                    Text(type.title)
                        .font(.subheadline.weight(.medium))
                }
            }
            .padding(.horizontal, 10)
        }
        .frame(width: viewType == .grid ? 110 : nil, height: viewType.frameSize)
        .cornerRadius(12)
        .onTapGesture {
            selectedType = type
        }
    }
}
