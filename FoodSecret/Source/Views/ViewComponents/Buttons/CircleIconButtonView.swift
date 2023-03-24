//
//  CircleIconButtonView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 24.03.2023.
//

import SwiftUI

struct CircleIconButtonView: View {
    var icon: String
    var hiddenBg: Bool = false
    var iconColor: Color = .white
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .imageScale(.medium)
                .padding(10)
                .background(hiddenBg ? .clear : .white.opacity(0.4), in: Circle())
        }
    }
}

struct CircleIconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            CircleIconButtonView(icon: "heart", action: {})
        }
    }
}
