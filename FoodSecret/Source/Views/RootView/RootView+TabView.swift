//
//  RootView+TabView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import SwiftUI

extension RootView{
    @ViewBuilder var tabView: some View{
        VStack(spacing: 0) {
            Divider()
            HStack{
                ForEach(Tab.allCases, id: \.self){ tab in
                    tabButton(tab)
                        .hCenter()
                        .onTapGesture {
                            rootVM.curretTab = tab
                        }
                }
            }
            .padding(.top, 5)
        }
        .background(Material.bar)
    }
    
    private func tabButton(_ tab: Tab) -> some View{
        VStack(spacing: 5){
            Image(systemName: rootVM.curretTab == tab ? tab.fillImageName : tab.imageName)
                .imageScale(.large)
            Text(tab.rawValue)
                .font(.caption2)
        }
        .foregroundColor(rootVM.curretTab == tab ? .accentColor : .secondary.opacity(0.8))
    }
}
