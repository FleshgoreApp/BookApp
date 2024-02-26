//
//  CategoryItem.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

struct CategoryItem: View {
    // MARK: - Properties
    var book: any Book
    var onSelect: ((any Book) -> ())?

    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
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
                .frame(width: 120, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .clipped()
            } else {
                ImagePlaceholder()
            }
            
            if let title = book.name {
                Text(title)
                    .font(.customFont(
                        fontName: .nunitoSansSemiBold,
                        size: .h5
                    ))
                    .foregroundStyle(.secondaryCustom)
            }
        }
        .frame(width: 120)
        .padding(.horizontal, 5)
        .onTapGesture {
            onSelect?(book)
        }
    }
}

#Preview {
    CategoryItem(book: CategoryItemSample.sample.first!)
}
