//
//  ContentView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
//    @StateObject var viewModel = HomeViewModel()
    @FetchRequest(fetchRequest: FoodEntity.fetchForDate(), animation: .default)
    var foods: FetchedResults<FoodEntity>
    var body: some View {
        NavigationStack {
            List{
                ForEach(MealType.allCases, id: \.self) { mealType in
                    Section {
                        ForEach(foods.filter({$0.mealType == mealType})){ food in
                            Text(food.foodName ?? "non")
                                .swipeActions(edge: .trailing) {
                                    
                                    Button(role: .destructive) {
                                        FoodEntity.delete(food)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    
                                }
                        }
                    } header: {
                        Text(mealType.title)
                    }
                }
            }
            .navigationTitle("Today")
            .toolbar {
                 ToolbarItem {
                     Button(action: addItem) { Label("", systemImage: "plus")}
                 }
             }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let result = PersistenceController(inMemory: true)
        let viewContext = result.viewContext
        
        let food = FoodEntity(context: viewContext)
        food.id = UUID()
        food.foodName = "Eggs"
        food.mealType = .breakfast
        food.createAt = Date.now
        food.calories = 125.5
        food.image = "United"
        
       return ContentView()
            .environment(\.managedObjectContext, viewContext)
    }
}
extension ContentView{
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            FoodEntity.delete(at: offsets, for: Array(foods))
        }
    }
    
    private func addItem() {
          withAnimation {
              let newItem = FoodEntity(context: viewContext)
              newItem.id = UUID()
              newItem.foodName = "Eggs \(Int.random(in: 1...1000))"
              newItem.createAt = Date.now
              newItem.calories = 125.5
              newItem.mealType = .init(rawValue: Int16.random(in: 0...3)) ?? .breakfast
              viewContext.saveContext()
          }
      }
    
}


enum MealType: Int16, CaseIterable{
    case breakfast, lunch, dinner, snack
    
    var title: String{
        switch self {
        case .breakfast: return "Breakfast"
        case .lunch: return "Lunch"
        case .dinner: return "Dinner"
        case .snack: return "Snack"
        }
    }
}
