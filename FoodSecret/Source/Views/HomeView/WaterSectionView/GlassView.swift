//
//  GlassView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import SwiftUI

struct GlassView: View {
    let maxHeight: CGFloat = 50
    var progressHeight: CGFloat = 0
    var isLast: Bool = false
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom){
                Trapezoid()
                    .fill(Color.white)
                Trapezoid()
                    .fill(Color(.systemBlue).opacity(0.5))
                    .frame(height: progressHeight)
                    .scaleEffect(0.85)
                if isLast{
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                        .frame(maxHeight: .infinity, alignment: .center)
                }
            }
            .frame(width: proxy.size.width, height: maxHeight)
            .overlay(alignment: .trailing) {
                Trapezoid()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: proxy.size.width / 2)
            }
        }
        .animation(.spring(), value: progressHeight)
    }
}

struct GlassView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("secondaryBlue")
            GlassView(progressHeight: 50)
                .frame(width: 30, height: 60)
        }
    }
}



struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.15
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY ))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}
