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
                tabView
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
