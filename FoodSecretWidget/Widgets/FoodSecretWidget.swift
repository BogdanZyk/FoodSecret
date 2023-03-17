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
    let kind: String = "FoodSecretWidget"

    var body: some WidgetConfiguration {
        
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(context: viewContext!)) { entry in
            FoodSecretWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget 1")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct FoodSecretWidget_Previews: PreviewProvider {
    static var previews: some View {
        FoodSecretWidgetEntryView(entry: WidgetEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}



struct FoodSecretWidget2: Widget {
    var viewContext: NSManagedObjectContext?
    let kind: String = "FoodSecretWidget"

    var body: some WidgetConfiguration {
        
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(context: viewContext!)) { entry in
            FoodSecretWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget 2")
        .description("This is an example widget 2.")
        .supportedFamilies([.systemMedium, .systemSmall])
    }
}
