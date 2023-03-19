//
//  WaterSectionView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import SwiftUI

struct WaterSectionView: View {
    @EnvironmentObject var rootVM: RootViewModel
    let maxGlassesRange = 1...8
    var waterValue: Double{
        rootVM.water?.value ?? 0
    }
    var numberOfWaterGlasses: Int{
        rootVM.water?.glassesCoint ?? 0
    }
    
    var isCompletedWater: Bool{
        numberOfWaterGlasses == rootVM.halfInfo.waterInfo.glassesCount
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Tracking of water you drink")
                .font(.title3.bold())
            VStack(spacing: 16) {
                summarySection
                
                glassesSection
            }
            .foregroundColor(.white)
            .padding()
            .background(Color("secondaryBlue"))
            .cornerRadius(12)
        }
    }
}

struct WaterSectionView_Previews: PreviewProvider {
    static var previews: some View {
        WaterSectionView()
            .padding()
            .environmentObject(RootViewModel(mainContext: dev.viewContext))
    }
}


extension WaterSectionView{
    private var summarySection: some View{
        VStack(spacing: 0) {
            Text("Water")
                .font(.headline.bold())
            Group{
                if isCompletedWater{
                    Text("Daily target completed!")
                }else{
                    Text("Target \(rootVM.halfInfo.waterInfo.totalValue.treeNumString) L")
                }
            }
            .font(.caption2)
            
            Text(String(format: "%.2f L", waterValue))
                .font(.title3.weight(.medium))
                .padding(.top, 6)
        }
    }
    
    private var glassesSection: some View{
        HStack(spacing: 10){
            ForEach(maxGlassesRange, id: \.self) { index in
                GlassView(progressHeight: numberOfWaterGlasses >= index ? 50 : 0, isLast: numberOfWaterGlasses + 1 == index)
                    .overlay{
                        if index == maxGlassesRange.last, numberOfWaterGlasses > maxGlassesRange.last ?? 0{
                            Text("+\(numberOfWaterGlasses - (maxGlassesRange.last ?? 0))")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
            }
        }
        .frame(height: 55)
        .padding(.horizontal, 10)
        .onTapGesture {
            if !isCompletedWater {
                rootVM.updateWater(value: 0.25)
                Haptics.shared.notify(.success)
            }
        }
        .onLongPressGesture {
            rootVM.updateWater(value: -0.25)
            Haptics.shared.play(.heavy)
        }
    }
}
