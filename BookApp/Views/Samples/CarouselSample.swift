//
//  CarouselSample.swift
//  BookApp
//
//  Created by Anton Shvets on 25.02.2024.
//

import SwiftUI

enum CarouselSample {
    /// Carousel item with BookCard inside
    static let views = CategoryItemSample.sample.compactMap { book in
        CarouselItem {
            BookCard(
                book: book,
                size: .init(width: 200, height: 250)
            )
        }
    }
}
