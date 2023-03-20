//
//  HomeSymmaryView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import SwiftUI

struct HomeSymmaryView: View{
    @ObservedObject var healKit: HealthKitViewModel
    @EnvironmentObject var rootVM: RootViewModel
    let foods: [FoodEntity]
    var summaryData: (cal: Double, carbohyd: Double, protein: Double, fat: Double){
        Helper.symmaryNutritionData(for: foods)
    }
    
    var leftCallories: String{
        "\(Int(rootVM.halfInfo.totalCallories - summaryData.cal))"
    }
    var eatenCal: String{
        "\(Int(summaryData.cal))"
    }
    
    var burnedCal: String{
        healKit.callories
    }
    
    var body: some View{
        VStack(spacing: 20) {
            HStack(spacing: 45) {
                callLable(label: "Eaten", value: eatenCal)
                ProgressCircleView(persentage: summaryData.cal.calculatePercentage(for: rootVM.halfInfo.totalCallories), size: .large, circleOutline: Color.accentColor, circleTrack: Color(UIColor.systemTeal).opacity(0.3)) {
                    VStack {
                        Text(leftCallories)
                            .font(.headline.bold())
                        Text("cal left")
                            .font(.caption)
                    }
                    .withoutAnimation()
                }
                .frame(width: 110)
                .padding(.top, 6)
                callLable(label: "Burned", value: burnedCal)
            }
            .padding(.top, 6)
            
            HStack(spacing: 10){
                let macronut = rootVM.halfInfo.macronutrientsInGramm
                lineProgress(summaryData.carbohyd, title: "Carbs", total: macronut.carb)
                lineProgress(summaryData.protein, title: "Protein", total: macronut.protein)
                lineProgress(summaryData.fat, title: "Fat", total: macronut.fat)
            }
           
        }
        .padding()
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
    }
}

struct HomeSymmaryView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSymmaryView(healKit: HealthKitViewModel(), foods: dev.simpleFoods)
            .padding()
            .environmentObject(RootViewModel(mainContext: dev.viewContext))
    }
}





extension HomeSymmaryView{
    
    
    private func lineProgress(_ value: Double, title: String, total: Int) -> some View{
        VStack(spacing: 6){
            Text(title)
                .font(.caption)
            LineProgressView(value: CGFloat(value.calculatePercentage(for: Double(total))))
                .frame(height: 6)
            Text("\(Int(value)) / \(total) g")
                .font(.caption.weight(.medium))
        }
    }
    
    private func callLable(label: String, value: String) -> some View{
        VStack{
            Text(value)
                .font(.headline.bold())
            Text(label)
                .font(.caption)
        }
    }
}
