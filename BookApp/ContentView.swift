//
//  ContentView.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var viewState: ViewState = .loading
    
    var body: some View {
        switch viewState {
        case .loading:
            SplashView()
                .task {
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    viewState = .loaded
                }
        case .loaded:
            CoordinatorView()
        }
    }
}

#Preview {
    ContentView()
}
