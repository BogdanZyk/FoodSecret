//
//  DatePickerSheetView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 18.03.2023.
//

import SwiftUI

struct DatePickerSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var rootVM: RootViewModel
    var body: some View {
        VStack(spacing: 32){
            HStack{
                Button {
                    Haptics.shared.play(.light)
                    rootVM.selectedDate = Date()
                    dismiss()
                } label: {
                    Text("Today")
                        .font(.headline)
                }

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("Close")
                        .font(.headline)
                }
            }
            CustomDatePickerView(selectedDate: $rootVM.selectedDate)
                .onChange(of: rootVM.selectedDate) { _ in
                    Haptics.shared.play(.light)
                    rootVM.fetchCoreData()
                    dismiss()
                }
            Spacer()
        }
        .padding()
    }
}

struct DatePickerSheetView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerSheetView()
            .environmentObject(RootViewModel(mainContext: dev.viewContext))
    }
}
