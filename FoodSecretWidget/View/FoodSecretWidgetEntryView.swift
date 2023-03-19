//
//  FoodSecretWidgetEntryView.swift
//  FoodSecretWidgetExtension
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import WidgetKit
import SwiftUI



struct FoodSecretWidgetEntryView : View {
    let type: WidgetType
    var entry: Provider.Entry
    var body: some View {
        VStack(spacing: 10) {
            switch type{
            case .macronutrients:
                macronutrientsTypeView
            case .calSymmary:
                summaryType
            case .water:
                waterType
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("WidgetBackground"))
    }
}



struct FitzWidgets_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FoodSecretWidgetEntryView(type: .water, entry: WidgetEntry.placeholder())
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            FoodSecretWidgetEntryView(type: .calSymmary, entry: WidgetEntry(date: Date(), configuration: ConfigurationIntent.init()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            FoodSecretWidgetEntryView(type: .calSymmary, entry: WidgetEntry.placeholder())
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}



//MARK: - Macronutrient type
extension FoodSecretWidgetEntryView{
    @ViewBuilder
    private var macronutrientsTypeView: some View{
        Text(entry.date.formatted(date: .abbreviated, time: .shortened))
            .font(.caption2.bold())
            .foregroundColor(.secondary)
        if entry.usedMacronutrients != nil{
            MacronutrientsCirclesProgressView(entry: entry)
        }else{
            MacronutrientsCirclesProgressView(entry: WidgetEntry.placeholder())
                .redacted(reason: .placeholder)
        }
        Spacer()
    }
}

//MARK: - Summary type

extension FoodSecretWidgetEntryView{
    @ViewBuilder
    private var summaryType: some View{
        if entry.usedMacronutrients != nil{
            SymmaryCalloriesProgressView(entry: entry)
        }else{
            SymmaryCalloriesProgressView(entry: WidgetEntry.placeholder())
                .redacted(reason: .placeholder)
        }
    }
}


//MARK: - Water type

extension FoodSecretWidgetEntryView{
    @ViewBuilder
    private var waterType: some View{
        let maxValue = Double(entry.water.maxWaterGlasses) * 0.25
        let value = entry.water.waterValue ?? 0
        let persent = value.calculatePercentage(for: maxValue)
        
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Spacer()
                Image(systemName: "drop.fill")
                    .imageScale(.large)
                      .foregroundColor(Color(.systemCyan))
            }
            VStack(alignment: .leading){
                Text(String(format: "%.2f L", value))
                    .font(.title.weight(.medium))
                Text("Target \(maxValue.treeNumString) L")
                    .font(.caption)
            }
            LineProgressView(value: persent)
                .frame(height: 5)
                .padding(.top)
            Spacer()
        }
        .padding(.horizontal, 5)
    }
}

struct SymmaryCalloriesProgressView: View{
    var entry: Provider.Entry

    var body: some View{
        
        if let usedData = entry.usedMacronutrients, let totalData = entry.totalMacronutrients{
            let leftCal = totalData.callories - usedData.callories
            HStack(spacing: 50){
                VStack {
                    Text("\(usedData.callories) cal")
                        .font(.title2.weight(.medium))
                    Text("Eaten")
                        .font(.body.weight(.light))
                }
                ProgressCircleView(persentage: Double(usedData.callories).calculatePercentage(for: Double(totalData.callories)), size: .large, circleOutline: Color(.systemCyan), circleTrack: Color.secondary.opacity(0.5)) {
                    VStack {
                        Text("\(leftCal)")
                            .font(.title3.bold())
                        Text("left cal")
                            .font(.body.weight(.light))
                    }
                }
            }
            .padding()
        }
    }
}


struct MacronutrientsCirclesProgressView: View{
    var entry: Provider.Entry
    
    var body: some View{
        if let usedData = entry.usedMacronutrients, let totalData = entry.totalMacronutrients{
            HStack(spacing: 0){
                VStack(alignment: .leading, spacing: 20){
                    circleProgressView(total: totalData.callories, title: "Calories", currentValue: usedData.callories)
                    circleProgressView(total: totalData.carbs, title: "Carbs", currentValue: usedData.carbs)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 20){
                    circleProgressView(total: totalData.proteins, title: "Protein", currentValue: usedData.proteins)
                    circleProgressView(total: totalData.fats, title: "Fats", currentValue: usedData.fats)
                }
            }
            .padding(.horizontal)
        }
        
    }
}

 
extension MacronutrientsCirclesProgressView{
    private func circleProgressView(total: Int, title: String, currentValue: Int) -> some View{
        HStack{
            ProgressCircleView(persentage: Double(currentValue).calculatePercentage(for: Double(total)), size: .verySmall, circleOutline: Color(.systemCyan), circleTrack: Color.secondary.opacity(0.5)) {
                EmptyView()
            }
            VStack(alignment: .leading){
                Text(title)
                    .font(.subheadline.bold())
                Text("\(currentValue) / \(Int(total))")
                    .font(.caption2)
            }
        }
    }
}
