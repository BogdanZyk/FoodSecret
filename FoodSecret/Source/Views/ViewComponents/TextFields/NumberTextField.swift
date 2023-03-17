//
//  NumberTextField.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import SwiftUI

struct NumberTextField: View{
    @Binding var value: Double
    let promt: String
    let label: String
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View{
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            TextField(promt, value: $value, formatter: formatter)
                .font(.title3.weight(.medium))
                .keyboardType(.decimalPad)
            Divider()
        }
    }
}

struct NumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        NumberTextField(value: .constant(10), promt: "", label: "Height")
    }
}
