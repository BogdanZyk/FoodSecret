//
//  ContentView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 14.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/// client id    5f3fbc236bdc46f9bec75207947ae17b
///secret key   11a3e1963ac84f6385bef1df593f8558
