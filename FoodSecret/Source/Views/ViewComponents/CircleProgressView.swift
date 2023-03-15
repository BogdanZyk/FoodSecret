//
//  CircleProgressView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI

import SwiftUI

struct ProgressCircleView<Label: View>: View {
    var label: (() -> Label)?
    var persentage: CGFloat
    var size: Size = .large
    var animate: Bool = false
    var circleOutline: Color = .green
    var circleTrack: Color = .gray
    
    
    init(persentage: CGFloat,
         size: ProgressCircleView.Size = .large,
         animate: Bool = false,
         circleOutline: Color = .green,
         circleTrack: Color = .gray,
         label: (() -> Label)? = nil) {
        
        self.label = label
        self.persentage = persentage
        self.size = size
        self.animate = animate
        self.circleOutline = circleOutline
        self.circleTrack = circleTrack
    }
    
    
    @State private var animatePersantage: CGFloat = 0
    var body: some View {
        ZStack{
            Circle()
                .stroke(style: .init(lineWidth: size.lineWidth, lineCap: .round, lineJoin: .round))
                .fill(circleTrack)
            Circle()
                .trim(from: 0, to: animate ? animatePersantage : persentage)
                .stroke(style: .init(lineWidth: size.lineWidth, lineCap: .round, lineJoin: .round))
                .fill(circleOutline)
                .rotationEffect(.init(degrees: -90))
            if let label{
                label()
            }
        }
        .onAppear{
            if animate{
                withAnimation(.spring(response: 3)) {
                    animatePersantage = persentage
                }
            }
        }
        .frame(minWidth: size.frameSize, maxHeight: size.frameSize)
    }
}

extension ProgressCircleView{
    enum Size{
        case small, medium, large
        
        
        var frameSize: CGFloat?{
            switch self{
            case .small:
                return 45
            case .medium:
                return 90
            case .large:
                return nil
            }
        }
        
        var lineWidth: CGFloat{
            switch self{
            case .small:
                return 8
            case .medium, .large:
                return 15
            }
        }
    }
}

struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 60){
            ProgressCircleView(persentage: 0.5, size: .small, animate: true) {
                Text("test")
            }
            ProgressCircleView(persentage: 0.25, size: .medium) {
                Text("test2")
            }
        }
        
    }
}