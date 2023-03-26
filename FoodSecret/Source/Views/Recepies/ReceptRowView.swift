//
//  ReceptRowView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import SwiftUI

struct ReceptRowView: View {
    @State private var isFavorite: Bool = false
    let recept: Recipe
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack{
                Color.white
                NukeLazyImage(strUrl: recept.image, resizingMode: .aspectFill)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(recept.label)
                    .font(.subheadline.bold())
                    .multilineTextAlignment(.leading)
                HStack {
                    Text(recept.calories?.toCalories ?? "")
                    Text(recept.timeFriedly)
                }
                .font(.footnote.weight(.medium))
            }
            .foregroundColor(.primaryFont)
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .hLeading()
        .background(Color(.systemGray6))
        .frame(height: getRect().height / 3)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.15), radius: 5)
        .overlay(alignment: .topTrailing) {
            favoriteButton
        }
    }
}

struct ReceptRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReceptRowView(recept: MockEdamam.recept)
            .padding()
    }
}

extension ReceptRowView{
    private var favoriteButton: some View{
        CircleIconButtonView(icon: isFavorite ? "heart.fill" : "heart") {
            isFavorite.toggle()
        }
        .padding()
    }
}


