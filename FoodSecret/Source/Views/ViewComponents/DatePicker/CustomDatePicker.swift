//
//  CustomDatePicker.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 18.03.2023.
//

import SwiftUI


struct CustomDatePickerView: View {
    let dayofTheWeek: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @State private var currentDate: Date = Date()
    @State private var currentMonth: Int = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            mounthSection
           // divider
            //userStats
            divider
            daysSection
            dates
                
        }
        
        .foregroundColor(.primaryFont)
//        .padding(16)
//        .background(Color.secondary, in: RoundedRectangle(cornerRadius: 20))
    }
}

struct CustomCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
           // Color.black
            CustomDatePickerView()
                .padding()
        }
    }
}


extension CustomDatePickerView{
    private var mounthSection: some View{
        HStack{
            Text("\(extractDate())")
                .font(.title3)
                .bold()
            Spacer()
            HStack(spacing: 0){
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .padding(10)
                }
                Button{
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .padding(10)
                }
            }
            .font(.subheadline.bold())
            .onChange(of: currentMonth) { newValue in
                currentDate = getCurrentMonth()
            }
        }
    }
    
    private var userStats: some View{
        HStack{
            Spacer()
            statsView(title: "total", value: "100")
            Spacer()
            statsView(title: "longest", value: "70")
            Spacer()
            statsView(title: "current", value: "54")
            Spacer()
        }
        .hCenter()
    }
    
    private func statsView(title: String, value: String) -> some View{
        VStack(spacing: 18) {
            Text(title)
                //.font(.urbRegular(size: 16))
            HStack{
                Text(value)
                    .font(.title3).bold()
                Text("days")
                    //.font(.urbRegular(size: 16))
            }
            
        }
    }
    private var divider: some View{
        Divider().background(.white.opacity(0.5))
    }
}


extension CustomDatePickerView{
    private var daysSection: some View{
        HStack{
            ForEach(dayofTheWeek, id: \.self) { day in
                Text(day)
                    .font(.headline.bold())
                    .foregroundColor(.white.opacity(0.6))
                    .hCenter()
            }
        }
    }
    
    
    @ViewBuilder
    private var dates: some View{
        let columns = Array(repeating: GridItem(.flexible()), count: 7)
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(extractDate()) { value in
                daysViewComponent(value.day, isToday: isSameDate(value.date))
            }
        }
        .padding(.top)
    }
    
    private func isSameDate(_ date: Date) -> Bool {
        let calendar = Calendar.current
       return calendar.isDateInToday(date)
    }
    
    
    //MOCKS user MOOD State
    private func daysViewComponent(_ day: Int, isToday: Bool) -> some View{
        //let randomDays: [Int] = Array(0...6)
       return VStack{
            if day != -1{
                Text("\(day)")
                    //.font(.urbMedium(size: 18))
                    .frame(width: 25, height: 25)
                    .background(Color.white.opacity(isToday ? 0.2 : 0), in: RoundedRectangle(cornerRadius: 5))
//                    .overlay{
//                        if randomDays.contains(day){
//                            Text("\(MoodType.allCases.randomElement()?.rawValue ?? MoodType.love.rawValue)")
//                        }
//                    }
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
    
    private func extractDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.string(from: currentDate)
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
