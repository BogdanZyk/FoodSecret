//
//  AllMealsFoodView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

struct AllMealsFoodView: View {
    @Environment(\.managedObjectContext) var viewContext
    var foods: FetchedResults<FoodEntity>
    var body: some View {
        List {
            ForEach(MealType.allCases, id: \.self){type in
                Section {
                    ForEach(Array(foods).filter({$0.mealType == type})){food in
                        NavigationLink {
                            UpdateView(item: food)
                        } label: {
                            Text(food.foodNameEditable)
                                .font(.headline)
                        }
                    }
                } header: {
                    HStack{
                        Text(type.title)
                        Spacer()
                        Text("\(type.getTotalCallForType(with: Array(foods)).friendlyString) call")
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Meals")
        .navigationBarTitleDisplayMode(.inline)
//        .navigationDestination(for: FoodEntity.self) { item in
//            UpdateView(item: item)
//        }
    }
}

//struct AllMealsFoodView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            AllMealsFoodView(foods: dev.simpleFoods)
//                .environment(\.managedObjectContext, dev.viewContext)
//        }
//    }
//}

extension AllMealsFoodView{
    
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

