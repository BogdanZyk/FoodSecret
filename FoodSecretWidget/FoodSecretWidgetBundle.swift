//
//  FoodSecretWidgetBundle.swift
//  FoodSecretWidget
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import WidgetKit
import SwiftUI

@main
struct FoodSecretWidgetBundle: WidgetBundle {
    let context = PersistenceController.shared.viewContext
    var body: some Widget {
        FoodSecretWidget(viewContext: context)
        FoodSecretWidget2(viewContext: context)
    }
}
