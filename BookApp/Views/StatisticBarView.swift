//
//  StatisticBarView.swift
//  BookApp
//
//  Created by Anton Shvets on 24.02.2024.
//

import SwiftUI

struct StatisticBarView: View {
    // MARK: - Properties
    private let items: [StatisticBarModel]
    private let barHeight: CGFloat = 36
    
    // MARK: - Initialization
    init(items: [StatisticBarModel]) {
        self.items = items
    }
    
    // MARK: - View
    var body: some View {
        HStack(spacing: 30) {
            ForEach(items) { item in
                VStack(spacing: .zero) {
                    Text(item.title)
                        .font(.customFont(
                            fontName: .nunitoSansBold,
                            size: .h2
                        ))
                        .foregroundStyle(.mainText)
                        .lineLimit(1)
                        .frame(height: CustomFontSize.h3.rawValue)
                    
                    Text(item.subtitle)
                        .font(.customFont(
                            fontName: .nunitoSansSemiBold,
                            size: .h6
                        ))
                        .foregroundStyle(.disabledGray)
                        .lineLimit(1)
                }
            }
        }
        .frame(height: barHeight)
        .foregroundStyle(.gray)
    }
}

#Preview {
    let items = Converter.getStatisticBarModelsFrom(book: CategoryItemSample.sample.first!)
    return StatisticBarView(items: items)
}
