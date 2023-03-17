//
//  FoodSecretApp.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import SwiftUI

@main
struct FoodSecretApp: App {
    @StateObject var rootViewModel = RootViewModel(mainContext: PersistenceController.shared.viewContext)
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(rootViewModel)
        }
    }
}
