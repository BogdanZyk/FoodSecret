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
    let label: String?
    var withDivider: Bool = true
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View{
        VStack(alignment: .leading) {
            if let label{
                Text(label)
                    .font(.headline)
            }
            TextField(promt, value: $value, formatter: formatter)
                .font(.title3.weight(.medium))
                .keyboardType(.decimalPad)
            if withDivider{
                Divider()
            }
        }
    }
}

struct NumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        NumberTextField(value: .constant(10), promt: "", label: "Height")
    }
}


