//
//  ContentView.swift
//  Spin.SwiftUI.Demo.Basic
//
//  Created by Thibault Wittemberg on 2020-02-14.
//  Copyright © 2020 Spinners. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ReactiveSwiftView()
                .tabItem {
                    Image(systemName: "gobackward.10")
                    Text("ReactiveSwift")
                }
            RxSwiftView()
                .tabItem {
                    Image(systemName: "gobackward.10")
                    Text("RxSwift")
                }
            CombineView()
                .tabItem {
                    Image(systemName: "gobackward.10")
                    Text("Combine")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
