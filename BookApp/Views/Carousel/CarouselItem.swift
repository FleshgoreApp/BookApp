//
//  CarouselItem.swift
//  BookApp
//
//  Created by Anton Shvets on 25.02.2024.
//

import SwiftUI

struct CarouselItem: View, Identifiable {    
    let id = UUID()
    @ViewBuilder var content: any View
    
    var body: some View {
        AnyView(content)
    }
}

#Preview {
    ZStack {
        Color.clear
        CarouselItem {
            BookCard(
                book: CategoryItemSample.sample.last!,
                size: .init(width: 200, height: 250)
            )
        }
    }
    .background(.black)
}
