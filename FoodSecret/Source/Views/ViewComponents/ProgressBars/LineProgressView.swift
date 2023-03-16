//
//  LineProgressView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import SwiftUI

struct LineProgressView: View {
    var value: CGFloat
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(value * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
            }.cornerRadius(45.0)
        }
        .animation(.spring(response: 3), value: value)
    }
}

struct LineProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LineProgressView(value: 0.5)
                .frame(height: 10)
            LineProgressView(value: 0.8)
                .frame(height: 10)
        }
        .padding()
    }
}
