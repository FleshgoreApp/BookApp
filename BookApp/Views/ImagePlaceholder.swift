//
//  ImagePlaceholder.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

struct ImagePlaceholder: View {
    var body: some View {
        ZStack {
            Color(.grayCustom)
            Image(systemName: "book")
                .resizable()
                .foregroundStyle(.gray)
                .scaledToFit()
                .padding(15)
        }
    }
}

#Preview {
    ImagePlaceholder()
        .frame(width: 120, height: 150)
}
