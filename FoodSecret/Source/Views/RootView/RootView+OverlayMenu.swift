//
//  RootView+OverlayMenu.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 19.03.2023.
//

import SwiftUI

extension RootView{
    
    @ViewBuilder
    var overlayView: some View{
        Group{
            if rootVM.showMealsMenu{
                Color.black.opacity(0.65).ignoresSafeArea()
                    .onTapGesture {
                        Haptics.shared.play(.light)
                        rootVM.showMealsMenu.toggle()
                    }
            }
            if rootVM.curretTab == .home{
                VStack(alignment: .trailing, spacing: 12) {
                    if rootVM.showMealsMenu{
                        MealMenuView { type in
                            Haptics.shared.play(.light)
                            rootVM.showMealsMenu = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                                rootVM.showAddFoodView(type)
                            }
                        }
                        .padding(.trailing, 10)
                    }
                    
                    ZStack {
                        Circle()
                            .fill(Color.accentColor)
                            .shadow(color: .black.opacity(0.1), radius: 5)
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .imageScale(.large)
                            .rotationEffect(.degrees(rootVM.showMealsMenu ? 45 : 0))
                    }
                    .frame(width: 55, height: 55)
                    .onTapGesture {
                        Haptics.shared.play(.light)
                        rootVM.showMealsMenu.toggle()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .trailing, vertical: .bottom))
            }
        }
        .animation(.easeInOut(duration: 0.15), value: rootVM.showMealsMenu)
    }
}
