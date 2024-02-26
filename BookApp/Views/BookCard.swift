//
//  BookCard.swift
//  BookApp
//
//  Created by Anton Shvets on 25.02.2024.
//

import SwiftUI

struct BookCard: View {
    var book: any Book
    var size: CGSize
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            if let urlString = book.coverUrl {
                
                CachedImage(url: urlString) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        ImagePlaceholder()
                    } else {
                        LoaderView()
                    }
                }
                .frame(width: size.width, height: size.height)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .clipped()
            } else {
                ImagePlaceholder()
            }
            
            if let title = book.name {
                Text(title)
                    .font(.customFont(
                        fontName: .nunitoSansBold,
                        size: .h3
                    ))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.top, 16)
            }
            
            if let title = book.author {
                Text(title)
                    .font(.customFont(
                        fontName: .nunitoSansBold,
                        size: .h6
                    ))
                    .foregroundStyle(.disabledGray)
                    .lineLimit(1)
            }
        }
        .frame(width: size.width)
    }
}

#Preview {
    ZStack {
        Color.black
        BookCard(
            book: CategoryItemSample.sample.first!,
            size: .init(width: 200, height: 250)
        )
    }
}
