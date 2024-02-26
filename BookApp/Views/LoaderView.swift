//
//  LoaderView.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

struct LoaderView: View {
    @State private var isLoading = false
    
    var body: some View {
        HStack {
            ForEach(0...2, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(.pinkLight)
                    .scaleEffect(self.isLoading ? 0 : 1)
                    .animation(
                        .linear(duration: 0.8)
                        .repeatForever()
                        .delay(0.2 * Double(index)),
                        value: isLoading
                    )
            }
        }
        .onAppear() {
            self.isLoading = true
        }
    }
}

#Preview {
    LoaderView()
}
