//
//  RootView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootVM: RootViewModel
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        TabView(selection: $rootVM.curretTab) {
            homeViewContainer
            recepiesViewContainer
            profileViewContainer
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(RootViewModel(mainContext: dev.viewContext))
    }
}


extension RootView{
    
    private var homeViewContainer: some View{
        NavigationStack{
            VStack(spacing: 0){
                HomeView()
                    .overlay{
                        overlayView
                    }
                tabView
                    .overlay {
                        Group{
                            if rootVM.showMealsMenu{
                                Color.secondary.opacity(0.5).ignoresSafeArea()
                            }
                        }
                        .animation(.easeInOut(duration: 0.2), value: rootVM.showMealsMenu)
                    }
            }
        }
        .tag(Tab.home)
    }

    private var recepiesViewContainer: some View{
        NavigationStack {
            VStack(spacing: 0){
                Text("recepies")
                Spacer()
                tabView
            }
        }
        .tag(Tab.recepies)
    }
    
    private var profileViewContainer: some View{
        NavigationStack {
            VStack(spacing: 0) {
                ProfileView()
                tabView
            }
        }
        .tag(Tab.profile)
    }
}

extension RootView{
    
    @ViewBuilder
    private var overlayView: some View{
        Group{
            if rootVM.showMealsMenu{
                Color.secondary.opacity(0.5).ignoresSafeArea()
                    .onTapGesture {
                        rootVM.showMealsMenu.toggle()
                    }
            }
            if rootVM.curretTab == .home{
                VStack(alignment: .trailing, spacing: 12) {
                    
                    if rootVM.showMealsMenu{
                        MealMenuView { type in
                            rootVM.showMealsMenu = false
                            rootVM.showAddFoodView(type)
                        }
                        .padding(.trailing, 10)
                    }
                    
                    ZStack {
                        Circle()
                            .fill(Color.accentColor)
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .imageScale(.large)
                            .rotationEffect(.degrees(rootVM.showMealsMenu ? 45 : 0))
                    }
                    .frame(width: 55, height: 55)
                    
                    //.padding(.bottom, 45)
                    .onTapGesture {
                        rootVM.showMealsMenu.toggle()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .trailing, vertical: .bottom))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: rootVM.showMealsMenu)
    }
    
}
