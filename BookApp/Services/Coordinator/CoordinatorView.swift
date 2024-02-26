//
//  CoordinatorView.swift
//  BookApp
//
//  Created by Anton Shvets on 22.02.2024.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .main)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CoordinatorView()
}
