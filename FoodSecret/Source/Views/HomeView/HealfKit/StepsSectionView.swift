//
//  StepsSectionView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 20.03.2023.
//

import SwiftUI

struct StepsSectionView: View {
    @EnvironmentObject var rootVM: RootViewModel
    @ObservedObject var viewModel: HealthKitViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Steps")
                .font(.title3.bold())
            VStack {
                if viewModel.isSetUpHealth {
                    VStack(spacing: 16) {
                        stepsSection
                        progressSection
                    }
                } else {
                    VStack {
                        Text("Retrace your steps")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        Button {
                            viewModel.healthRequest(for: Date.now)
                        } label: {
                            Text("Authorize HealthKit")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .buttonStyle(CapsuleButton())
                    }
                }
            }
            .hCenter()
            .padding()
            .background(Color.primaryOrange)
            .cornerRadius(12)
            .onChange(of: rootVM.selectedDate) { newDay in
                viewModel.fetchHealfData(newDay)
            }
        }
    }
}

struct StepsSectionView_Previews: PreviewProvider {
    static var previews: some View {
        StepsSectionView(viewModel: HealthKitViewModel())
            .padding()
            .environmentObject(RootViewModel(mainContext: dev.viewContext))
    }
}


extension StepsSectionView{
    private var stepsSection: some View{
        VStack{
            Text("\(viewModel.userStepCount) steps")
                .font(.title3.bold())
            Text("\(viewModel.callories) cal")
                .font(.subheadline)
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    private var progressSection: some View{
        let persent = (Double(viewModel.userStepCount) ?? 0.0).calculatePercentage(for: 10_000)
        LineProgressView(value: persent, colorBgLine: .white.opacity(0.5))
            .frame(height: 20)
    }
}
