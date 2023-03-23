//
//  ReceptRowView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 23.03.2023.
//

import SwiftUI

struct ReceptRowView: View {
    let recept: Recipe
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NukeLazyImage(strUrl: recept.image)
                .hCenter()
            VStack(alignment: .leading, spacing: 4) {
                Text(recept.label)
                    .font(.subheadline.bold())
                Text(recept.calories?.toCalories ?? "")
                    .font(.footnote)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .hLeading()
        .background(Color(.systemGray6))
        .frame(height: 220)
        .cornerRadius(12)
    }
}

struct ReceptRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReceptRowView(recept: .init(uri: "", label: "Title", image: "", images: nil, source: nil, url: nil, shareAs: nil, yield: nil, dietLabels: [], healthLabels: [], cautions: [], ingredientLines: [], ingredients: [], calories: 235, totalWeight: 100, cuisineType: [], mealType: [], dishType: [], externalId: ""))
            .padding()
    }
}
