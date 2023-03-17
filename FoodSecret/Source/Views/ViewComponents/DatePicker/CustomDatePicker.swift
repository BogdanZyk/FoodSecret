//
//  CustomDatePicker.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 18.03.2023.
//

import SwiftUI


struct CustomDatePickerView: View {
    @Binding var selectedDate: Date
    @State private var currentMonth: Int = 0
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 10){
                mounthSection
                daysSection
                dates
            }
            .foregroundColor(.primaryFont)
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .top)
        }
        .frame(height: 340)
    }
}

struct CustomCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
           // Color.black
            CustomDatePickerView(selectedDate: .constant(.tomorrow))
               
                .padding()
        }
    }
}


extension CustomDatePickerView{
    private var mounthSection: some View{
        HStack{
            HStack(spacing: 0){
                Button {
                    currentMonth -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .padding(10)
                        .foregroundColor(.accentColor)
                }
                
                Text(extractMonthDate())
                    .font(.title3)
                    .bold()
                    .hCenter()
                Button{
                    currentMonth += 1
                } label: {
                    Image(systemName: "chevron.right")
                        .padding(10)
                        .foregroundColor(.accentColor)
                }
            }
            .font(.subheadline.bold())
        }
    }
}


extension CustomDatePickerView{
    private var daysSection: some View{
        HStack{
            ForEach(daysOfWeek, id: \.self) { day in
                Text(day)
                    .font(.headline.bold())
                    .foregroundColor(.secondary)
                    .hCenter()
            }
        }
    }
    
    private var daysOfWeek: [String]{
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en")
        return formatter.shortWeekdaySymbols
    }
    
    
    @ViewBuilder
    private var dates: some View{
        let columns = Array(repeating: GridItem(.flexible()), count: 7)
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(extractDate()) { value in
                daysViewComponent(value.day, date: value.date)
                    .onTapGesture {
                        selectedDate = value.date
                    }
            }
        }
        .padding(.top)
    }
    
    private func isSameDate(_ date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(date)
    }
    
    @ViewBuilder
    private func daysViewComponent(_ day: Int, date: Date) -> some View{
        let isToday = isSameDate(date)
         VStack{
            if day != -1{
                Text("\(day)")
                    .font(.title3)
                    .frame(width: 25, height: 25)
                    .foregroundColor(isToday ? .white : (date == selectedDate ? .blue : .primaryFont))
                    .padding(5)
                    .background(isToday ? Color.accentColor : .clear, in: Circle())
            }
        }
    }
    
    
    private func extractDate() -> [DateValue]{
        let calendar = Calendar.current
      
        let currentMounth = getCurrentMonth()
        var days = currentMounth.getAllDatesOfMonth().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<(firstWeekday - 1){
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    private func getCurrentMonth() -> Date{
        let calendar = Calendar.current
        guard let currentMounth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else {return Date()}
        return currentMounth
    }
    
    private func extractMonthDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.string(from: getCurrentMonth())
    }
}



extension Date {

    func getAllDatesOfMonth() -> [Date]{
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: self)!
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
   
 }


struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
