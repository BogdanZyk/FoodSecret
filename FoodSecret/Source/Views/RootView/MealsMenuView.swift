//
//  MealsMenuView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 18.03.2023.
//

import SwiftUI

struct MealMenuView: View{
   
    @State private var menuButtons: [MenuType]
    @State private var animateView: Bool = false
    var onTap: (MealType) -> Void
    
    init(onTap: @escaping (MealType) -> Void){
        menuButtons = MealType.allCases.map({.init(type: $0, emoji: $0.emoji, title: $0.title)})
        self.onTap = onTap
    }
 
    var body: some View{
        VStack(alignment: .trailing, spacing: 10) {
            ForEach(menuButtons.indices, id: \.self) { index in
                HStack(spacing: 15){
                    Text(menuButtons[index].title)
                        .foregroundColor(.primaryFont)
                        .font(.subheadline.weight(.medium))
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
                    
                    Text(menuButtons[index].emoji)
                        .font(.system(size: 23))
                        .padding(6)
                        .background(Color(.systemGray6), in: Circle())
                }
                .scaleEffect(menuButtons[index].isAnimate ? 1 : 0.01)
                .onAppear{
                    withAnimation(.spring().delay(Double(index) * 0.06)){
                        menuButtons[(menuButtons.count - 1) - index].isAnimate = true
                    }
                }
                .onTapGesture {
                    onTap(menuButtons[index].type)
                }
            }
        }
        .onAppear{
            withAnimation(.spring()) {
                animateView = true
            }
        }
    }
}



struct EmojiReactionView2_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            MealMenuView(onTap: {_ in})
        }
        
    }
}



extension MealMenuView{
    struct MenuType{
        var type: MealType
        var emoji: String
        var title: String
        var isAnimate: Bool = false
    }
}
