//
//  FoodSecretWidget.swift
//  FoodSecretWidget
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData


struct FoodSecretWidget: Widget {
    var viewContext: NSManagedObjectContext?
    var kind: String { widgetType.kind }
    var widgetType: WidgetType = .macronutrients
    var body: some WidgetConfiguration {
        
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(context: viewContext!)) { entry in
            FoodSecretWidgetEntryView(type: widgetType, entry: entry)
        }
        .configurationDisplayName(widgetType.rawValue)
        .description(widgetType.description)
        .supportedFamilies([widgetType.supportedFamilies])
    }
}

struct FoodSecretWidget_Previews: PreviewProvider {
    static var previews: some View {
        FoodSecretWidgetEntryView(type: .macronutrients, entry: WidgetEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}





enum WidgetType: String, CaseIterable{
    case macronutrients = "Macronutrients"
    case calSymmary = "Symmary"
    case water = "Water"
    
    var kind: String {"FoodSecretWidget" + self.rawValue}
    
    var description: String{
        switch self {
        case .macronutrients:
            return "Monitor your calorie and nutrient intake"
        case .calSymmary:
            return "View how many calories you've consumed and how many you have left"
        case .water:
            return "Keep track of your water consumption"
        }
    }
    
    var supportedFamilies: WidgetFamily{
        switch self {
        case .macronutrients, .calSymmary:
            return .systemMedium
        case .water:
            return .systemSmall
        }
    }
}
