//
//  ReceptDetailsView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 24.03.2023.
//

import SwiftUI

struct ReceptDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showHeader: Bool = false
    let recept: Recipe
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0){
                strechImageHeader
                VStack(alignment: .leading, spacing: 20){
                    Text(recept.label)
                        .font(.title2.bold())
                    infolabel
                    infoTags
                    ingredientsSection
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .overlay(alignment: .top) {
            navHeader
        }
    }
}

struct ReceptDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ReceptDetailsView(recept: MockEdamam.recept)
    }
}


extension ReceptDetailsView{
    
    private var strechImageHeader: some View{
        VStack{
            GeometryReader{ geo -> AnyView in
                DispatchQueue.main.async {
                    withAnimation {
                        showHeader = geo.offset <= -260
                    }
                }
                return AnyView(
                    ZStack{
                        if let image = recept.image{
                           NukeLazyImage(strUrl: image, resizeHeight: 300, resizingMode: .aspectFill, loadPriority: .veryHigh)
                        }
                    }
                    .frame(width: getRect().width, height: geo.height)
                    .offset(y: geo.verticalOffset)
                )
            }
            .frame(height: getRect().height / 2.5)
        }
    }
    
    private var infolabel: some View{
        HStack(spacing: 15) {
            ProductNutrionLabel(title: recept.calories?.toCalories ?? "0", subtitle: "Calories")
            ProductNutrionLabel(title: recept.totalWeight?.toWeight ?? "0", subtitle: "Weight")
            ProductNutrionLabel(title: recept.timeFriedly, subtitle: "Time")
        }
        .padding()
        .background(Color.secondaryBlue.opacity(0.2), in: RoundedRectangle(cornerRadius: 12))
    }
    
    @ViewBuilder
    private var infoTags: some View{
        let tags = recept.mealType + recept.cuisineType + recept.healthLabels
        tagView(tags)
    }
    
    private func tagView(_ tags: [String?]) -> some View{
        TagLayout(alignment: .leading, spacing: 10){
            ForEach(tags, id: \.self) { tag in
                if let tag{
                    Text(tag)
                        .font(.system(size: 14, weight: .medium))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 5)
                        .background(Color(.systemGray5), in: Capsule())
                }
            }
        }
    }
    
    private var ingredientsSection: some View{
        VStack(alignment: .leading, spacing: 16) {
            Text("Ingredients")
                .font(.title3.bold())
            VStack(alignment: .leading, spacing: 10) {
                ForEach(recept.ingredients){ingredient in
                    HStack(spacing: 15) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color(.systemGray2))
                        Text(ingredient.food?.capitalized ?? "")
                            .font(.system(size: 18))
                        Spacer()
                        Text(ingredient.friedlyQuantityStr)
                            .font(.subheadline)
                        
                    }
                    Divider()
                }
            }
        }
        .padding(.top)
    }
    
    
    private var navHeader: some View{
        HStack(spacing: 15){
            
            CircleIconButtonView(icon: "chevron.left", hiddenBg: showHeader, iconColor: showHeader ? .accentColor : .white) {
                dismiss()
            }
           
            if showHeader{
                Spacer()
                Text(recept.label)
                    .font(.subheadline.bold())
                    .lineLimit(1)
            }
            Spacer()
            CircleIconButtonView(icon: "arrowshape.turn.up.right.fill", hiddenBg: showHeader, iconColor: showHeader ? .accentColor : .white) {
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
        .hCenter()
        .background(showHeader ? Color(.systemGray6) : .clear)
    }
}


