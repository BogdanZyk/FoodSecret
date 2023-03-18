//
//  CircleProgressView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 15.03.2023.
//

import SwiftUI


struct ProgressCircleView<Label: View>: View {
    var label: (() -> Label)?
    var persentage: CGFloat
    var size: Size = .large
    var circleOutline: Color = .green
    var circleTrack: Color = .gray
    
    
    init(persentage: CGFloat,
         size: ProgressCircleView.Size = .large,
         circleOutline: Color = .green,
         circleTrack: Color = .gray,
         label: (() -> Label)? = nil) {
        
        self.label = label
        self.persentage = persentage
        self.size = size
        self.circleOutline = circleOutline
        self.circleTrack = circleTrack
    }
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(style: .init(lineWidth: size.lineWidth, lineCap: .round, lineJoin: .round))
                .fill(circleTrack)
            Circle()
                .trim(from: 0, to: persentage)
                .stroke(style: .init(lineWidth: size.lineWidth, lineCap: .round, lineJoin: .round))
                .fill(circleOutline)
                .rotationEffect(.init(degrees: -90))
            if let label{
                label()
            }
        }
        .frame(minWidth: size.frameSize, maxHeight: size.frameSize)
        .animation(.spring(response: 3), value: persentage)
    }
}

extension ProgressCircleView{
    enum Size{
        case small, medium, large, verySmall
        
        
        var frameSize: CGFloat?{
            switch self{
            case .small:
                return 45
            case .medium:
                return 90
            case .large:
                return nil
            case .verySmall:
                return 30
            }
        }
        
        var lineWidth: CGFloat{
            switch self{
            case .small, .verySmall:
                return 6
            case .medium, .large:
                return 12
            }
        }
    }
}

struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 60){
            ProgressCircleView(persentage: 0.5, size: .small) {
                Text("test")
            }
            ProgressCircleView(persentage: 0.25, size: .medium) {
                Text("test2")
            }
        }
        
    }
}
