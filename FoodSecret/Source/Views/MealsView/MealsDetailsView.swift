//
//  MealsDetailsView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct MealsDetailsView: View {
    let viewType: MealType
   // let foods: [FoodEntity]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewType.title)
                    .font(.title3.weight(.medium))
            }
        }
    }
}

struct MealsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MealsDetailsView(viewType: .dinner)
        }
    }
}
