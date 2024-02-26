//
//  CategoryRow.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

struct CategoryRow: View {
    // MARK: - Properties
    var section: CategoryModel
    var onSelect: ((any Book) -> ())?
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text(section.title)
                .font(.customFont(
                    fontName: .nunitoSansBold,
                    size: .h3
                ))
                .foregroundStyle(.primary)
                .padding(.leading, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 0) {
                    ForEach(section.items, id: \.id) { book in
                        CategoryItem(book: book) { book in
                            onSelect?(book)
                        }
                    }
                }
                .padding(.horizontal, 11)
            }
        }
    }
}

#Preview {
    CategoryRow(section: .init(
        title: "Title",
        items: CategoryItemSample.sample)
    )
}

