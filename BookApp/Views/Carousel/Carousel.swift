//
//  Carousel.swift
//  BookApp
//
//  Created by Anton Shvets on 25.02.2024.
//

import SwiftUI

struct Carousel: View {
    // MARK: - Properties
    @State private var currentIndex: Int = .zero
    @GestureState private var dragOffset: CGFloat = .zero
    private var views: [CarouselItem] = []
    private var onIndexChanged: ((Int) -> Void)?
    private let itemWidth: CGFloat
    
    // Animation duration in seconds
    private let animationDuration: Double = 0.3
    
    // MARK: - Initialization
    init(itemWidth: CGFloat, views: [CarouselItem], onIndexChanged: ((Int) -> Void)? = nil) {
        self.itemWidth = itemWidth
        self.views = views
        self.onIndexChanged = onIndexChanged
    }
        
    // MARK: - View
    var body: some View {
        VStack {
            ZStack {
                ForEach(Array(views.enumerated()), id: \.offset) { index, view in
                    view
                        .opacity(currentIndex == index ? 1 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                        .offset(x: CGFloat(index - currentIndex) * (itemWidth * 1.1) + dragOffset)
                        .gesture(gesture)
                }
            }
            .animation(
                .linear(duration: animationDuration),
                value: UUID()
            )
        }
    }
    
    // MARK: - Private
    private var gesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, dragOffset, _ in
                dragOffset = value.translation.width
            }
            .onEnded { value in
                let threshold: CGFloat = 50
                if value.translation.width > threshold {
                    withAnimation(.linear(duration: animationDuration)) {
                        currentIndex = max(0, currentIndex - 1)
                        onIndexChanged?(currentIndex)
                    }
                } else if value.translation.width < -threshold {
                    withAnimation(.linear(duration: animationDuration)) {
                        currentIndex = min(views.count - 1, currentIndex + 1)
                        onIndexChanged?(currentIndex)
                    }
                }
            }
    }
}

#Preview {
    Carousel(itemWidth: 200, views: CarouselSample.views)
}
