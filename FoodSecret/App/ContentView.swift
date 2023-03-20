//
//  ContentView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

//import SwiftUI
//
//struct ContentView: View {
//    @EnvironmentObject var viewModel: RootViewModel
//    var body: some View {
//        NavigationStack {
//            List{
//                ForEach(MealType.allCases, id: \.self) { mealType in
//                    Section {
//                        ForEach(viewModel.foodForMeals(mealType)){ food in
//                            NavigationLink(value: food) {
//                                Text(food.foodName ?? "non")
//                            }
//                           
//                                .swipeActions(edge: .trailing) {
//                                    
//                                    Button(role: .destructive) {
//                                        viewModel.removeFood(food)
//                                    } label: {
//                                        Image(systemName: "trash")
//                                    }
//                                }
//                        }
//                    } header: {
//                        Text(mealType.title)
//                    }
//                }
//                
//                Section {
//                    
//                    HStack{
//                        Text(viewModel.water?.friendlyString ?? "0.00 l")
//                        Text("Glasses \(viewModel.water?.glassesCoint ?? 0)")
//                        Spacer()
//                        if let item = viewModel.water{
//                            Button {
//                                WaterEntity.delete(item)
//                            } label: {
//                                Image(systemName: "minus")
//                            }
//                            .buttonStyle(.plain)
//                        }
//                        
//                        Button {
//                            //viewModel.updateWater()
//                        } label: {
//                            Image(systemName: "plus")
//                        }
//                        .buttonStyle(.plain)
//                    }
//                } header: {
//                    Text("Water")
//                }
//            }
//            .navigationTitle("Today")
//            .toolbar {
//                 ToolbarItem {
//                     Button(action: addItem) { Label("", systemImage: "plus")}
//                 }
//             }
//            .navigationDestination(for: FoodEntity.self) { item in
//                UpdateView(item: item)
//                    .environmentObject(viewModel)
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(RootViewModel(mainContext: dev.viewContext))
//    }
//}
//extension ContentView{
//    
//    private func addItem() {
//       // viewModel.createFood()
//      }
//    
//}
//
//
//
//
//
//struct UpdateView: View{
//    @Environment(\.dismiss) var dismiss
//    @EnvironmentObject var rootVM: RootViewModel
//    @ObservedObject var item : FoodEntity
//    @State var name: String = ""
//    var body: some View{
//        Form{
//            TextField("name", text: $item.foodNameEditable)
//            Button("Save") {
//                item.managedObjectContext?.saveContext()
//                rootVM.fetchFoods()
//                dismiss()
//            }
//            Picker("", selection: $item.mealType) {
//                ForEach(MealType.allCases, id:\.self){type in
//                    Text(type.title)
//                        .tag(type)
//                }
//            }
//        }
//        .navigationTitle("Update \(item.foodNameEditable)")
//    }
//}
//
//
//
//
//
//
