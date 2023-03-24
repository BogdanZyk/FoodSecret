//
//  ImageSlider.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 24.03.2023.
//

import SwiftUI

struct ImageSlider: View {
    @State private var currentSlide: Int = 0
    let images: [String]
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            VStack(spacing: 20){
                TabView(selection: $currentSlide) {
                    ForEach(images.indices, id: \.self) { index in
                        if let image = images[index]{
                          NukeLazyImage(strUrl: image, resizingMode: .center)
                                .tag(index)
//                                .setImageInViewer(images: images, image: image)
                        }
                    }
                }
                .frame(width: size.width, height: size.height - 40)
                pageControl
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct ProductImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider(images: [])
            .frame(height: UIScreen.main.bounds.height / 3)
    }
}

extension ImageSlider{
    private var pageControl: some View{
        ImagePageControl(indices: images.indices, currentSlide: currentSlide)
    }
}


struct ImagePageControl: View{
    let indices: Range<Int>
    var currentSlide: Int
    var body: some View{
        HStack{
            ForEach(indices, id: \.self) { index in
                Circle()
                    .fill(currentSlide == index ? Color.gray : .white)
                    .frame(width: 6)
            }
        }
    }
}
