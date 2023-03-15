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
    @FetchRequest(fetchRequest: WaterEntity.fetchForDate(), animation: .default)
    var water: FetchedResults<WaterEntity>
    var body: some View {
        NavigationStack {
            List{
                ForEach(MealType.allCases, id: \.self) { mealType in
                    Section {
                        ForEach(foods.filter({$0.mealType == mealType})){ food in
                            NavigationLink(value: food) {
                                Text(food.foodName ?? "non")
                            }
                           
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
                
                Section {
                    
                    HStack{
                        Text(water.first?.friendlyString ?? "0.00 l")
                        Text("Glasses \(water.first?.glassesCoint ?? 0)")
                        Spacer()
                        if let item = water.first{
                            Button {
                                WaterEntity.delete(item)
                            } label: {
                                Image(systemName: "minus")
                            }
                            .buttonStyle(.plain)
                        }
                        
                        Button {
                            WaterEntity.update(water.first, context: viewContext)
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    Text("Water")
                }
            }
            .navigationTitle("Today")
            .toolbar {
                 ToolbarItem {
                     Button(action: addItem) { Label("", systemImage: "plus")}
                 }
             }
            .navigationDestination(for: FoodEntity.self) { item in
                UpdateView(item: item)
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


struct UpdateView: View{
    @Environment(\.dismiss) var dismiss
    @ObservedObject var item : FoodEntity
    @State var name: String = ""
    var body: some View{
        Form{
            TextField("name", text: $item.foodNameEditable)
            Button("Save") {
                item.managedObjectContext?.saveContext()
                dismiss()
            }
            Picker("", selection: $item.mealType) {
                ForEach(MealType.allCases, id:\.self){type in
                    Text(type.title)
                        .tag(type)
                }
            }
        }
        .navigationTitle("Update \(item.foodNameEditable)")
    }
}
