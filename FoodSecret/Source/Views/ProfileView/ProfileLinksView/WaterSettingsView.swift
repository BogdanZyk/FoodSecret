//
//  WaterSettingsView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 20.03.2023.
//

import SwiftUI

struct WaterSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isDisabled: Bool = true
    @State private var tempWater: WaterInfo
    @ObservedObject var profileVM: ProfileViewModel
    init(tempWater: WaterInfo, profileVM: ProfileViewModel){
        self._tempWater = State(wrappedValue: profileVM.halfInfo.waterInfo)
        self._profileVM = ObservedObject(wrappedValue: profileVM)
    }
    var body: some View {
        VStack(spacing: 30){
            waterTargetSection
            saveAndResetButton
            Spacer()
        }
        .padding()
        .navigationTitle("Water")
        .onChange(of: tempWater.totalValue) { _ in
            isDisabled = false
        }
    }
}

struct WaterSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WaterSettingsView(tempWater: .init(), profileVM: ProfileViewModel())
                .navigationBarTitleDisplayMode(.inline)

        }
    }
}


extension WaterSettingsView{
    
    private var waterTargetSection: some View{
        VStack(spacing: 20){
            Text("Target of the day")
                .font(.title2.bold())
            Divider()
            VStack(spacing: 16) {
                Text("\(tempWater.totalValue.treeNumString) ")
                    .font(.title2.bold()) +
                     Text("liters")
                    .font(.headline.bold())
                
                Text("\(tempWater.glassesCount) ")
                    .font(.title2.bold()) +
                Text("glasses")
                    .font(.headline.bold())
                Slider(value: $tempWater.totalValue, in: 1...3, step: 0.25)
                .padding()
            }
        }
    }
    
    private var saveAndResetButton: some View{
        VStack(spacing: 25) {
            Button {
                profileVM.saveWater(tempWater)
                dismiss()
            } label: {
                Text("Save")
            }
            .buttonStyle(CapsuleButton())
            .disabled(isDisabled)
            Button {
                tempWater = .init()
            } label: {
                Text("Reset")
            }
        }
    }
}
