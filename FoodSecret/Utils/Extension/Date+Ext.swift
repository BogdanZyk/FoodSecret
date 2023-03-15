//
//  Date+Ext.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import Foundation

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 00, minute: 0, second: 0, of: self)!
    }
    
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    func startOfMonth() -> Date{
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Calendar.current.startOfDay(for: self)))!
    }
    func endOfMonth() -> Date{
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
