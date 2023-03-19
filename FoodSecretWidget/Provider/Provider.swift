//
//  Provider.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import Foundation
import WidgetKit
import CoreData

struct Provider: IntentTimelineProvider {
    
    let coreDataManager: CoreDataManager
    
    init(context: NSManagedObjectContext) {
        self.coreDataManager = CoreDataManager(mainContext: context)
    }
    
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry.placeholder()
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetEntry) -> ()) {
        let entry = WidgetEntry.placeholder()
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> ()) {
        
        let currentDate = Date()
        let entry: WidgetEntry = createWidgetEntry(currentDate, configuration: configuration)
       

        let refreshDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
    
    func createWidgetEntry(_ date: Date, configuration: ConfigurationIntent) -> WidgetEntry{
        let foods = coreDataManager.fetchFoods(for: date)
        let water = coreDataManager.fetchWater(for: date)
        let halfInfo: UserHalfInfo = UserSettings.HalfInfo.info
        
        return .init(date: date, totalMacronutrients: .init(halfInfo), usedMacronutrients: .init(foods), configuration: configuration, water: .init(waterValue: water?.value, numberOfWaterGlasses: water?.glassesCoint, maxWaterGlasses: halfInfo.waterInfo.glassesCount))
    }
}
