//
//  View+extension.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import SwiftUI

extension View{
    
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
    
    //MARK: Vertical Center
    func vCenter() -> some View{
        self
            .frame(maxHeight: .infinity, alignment: .center)
    }
    //MARK: Vertical Top
    func vTop() -> some View{
        self
            .frame(maxHeight: .infinity, alignment: .top)
    }
    //MARK: Vertical Bottom
    func vBottom() -> some View{
        self
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
    //MARK: Horizontal Center
    func hCenter() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    //MARK: Horizontal Leading
    func hLeading() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    //MARK: Horizontal Trailing
    func hTrailing() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    //MARK: - All frame
    func allFrame() -> some View{
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func withoutAnimation() -> some View {
        self.animation(nil, value: UUID())
    }
    
    var isSmallScreen: Bool{
        getRect().height < 700
    }
}

extension UIViewController {
    
    func presentInKeyWindow(animated: Bool = true, completion: (() -> Void)? = nil) {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController?.present(self, animated: animated, completion: completion)
    }
}

/// client id    5f3fbc236bdc46f9bec75207947ae17b
///secret key   11a3e1963ac84f6385bef1df593f8558
