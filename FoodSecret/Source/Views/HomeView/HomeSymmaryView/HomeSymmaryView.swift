//
//  HomeSymmaryView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import SwiftUI

struct HomeSymmaryView: View{
    
    let foods: [FoodEntity]
    var summaryData: (cal: Double, carbohyd: Double, protein: Double, fat: Double){
        Helper.symmaryNutritionData(for: foods)
    }
    
    var body: some View{
        VStack(spacing: 20) {
            ProgressCircleView(persentage: summaryData.cal.calculatePercentage(for: 4500), size: .large, circleOutline: Color(UIColor.systemTeal), circleTrack: Color(UIColor.systemTeal).opacity(0.3)) {
                Text(summaryData.cal.toCalories)
                    .font(.subheadline.bold())
            }
            .frame(width: 100)
            .padding(.top, 6)
            HStack(spacing: 10){
                lineProgress(summaryData.carbohyd, title: "Carbs", total: 315)
                lineProgress(summaryData.protein, title: "Protein", total: 315)
                lineProgress(summaryData.fat, title: "Fat", total: 315)
            }
           
        }
        .padding()
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
    }
}

struct HomeSymmaryView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSymmaryView(foods: dev.simpleFoods)
            .padding()
    }
}





extension HomeSymmaryView{
    
    
    private func lineProgress(_ value: Double, title: String, total: Int) -> some View{
        VStack(spacing: 6){
            Text(title)
                .font(.caption)
            LineProgressView(value: CGFloat(value.calculatePercentage(for: Double(total))))
                .frame(height: 6)
            Text("\(Int(value))/\(total)")
                .font(.caption.weight(.medium))
        }
    }
    
}
