//
//  LineProgressView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 16.03.2023.
//

import SwiftUI

struct LineProgressView: View {
    var value: CGFloat
    var animate: Bool = false
    @State private var animateValue: CGFloat = 0
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min((animate ? animateValue : value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
            }.cornerRadius(45.0)
        }
        .onAppear{
            if animate{
                DispatchQueue.main.async {
                    withAnimation(.spring(response: 3)) {
                        animateValue = value
                    }
                }
            }
        }
    }
}

struct LineProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LineProgressView(value: 0.5, animate: true)
                .frame(height: 10)
            LineProgressView(value: 0.8, animate: false)
                .frame(height: 10)
        }
        .padding()
    }
}
