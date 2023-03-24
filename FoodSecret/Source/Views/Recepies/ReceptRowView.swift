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
            NukeLazyImage(strUrl: recept.image, resizingMode: .center)
                .hCenter()
            VStack(alignment: .leading, spacing: 4) {
                Text(recept.label)
                    .font(.subheadline.bold())
                HStack {
                    Text(recept.calories?.toCalories ?? "")
                    Text(recept.timeFriedly)
                }
                .font(.footnote.weight(.light))
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .hLeading()
        .background(Color(.systemGray6))
        .frame(height: 220)
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
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.white)
                .imageScale(.medium)
                .padding(10)
                .background(Material.ultraThin, in: Circle())
        }
        .padding()
    }
}


