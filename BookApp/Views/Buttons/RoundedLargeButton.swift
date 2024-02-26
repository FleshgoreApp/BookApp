//
//  RoundedLargeButton.swift
//  BookApp
//
//  Created by Anton Shvets on 25.02.2024.
//

import SwiftUI

typealias Completion = () -> Void

struct RoundedLargeButton: View {
    // MARK: - Properties
    private let title: String
    private let titleColor: Color
    private let backgroundColor: Color
    private let action: Completion
    
    // MARK: - Initialization
    init(title: String,
         titleColor: Color = .white,
         backgroundColor: Color = .blue,
         action: @escaping Completion
    ) {
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    // MARK: - View
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Text(title)
                    .font(.customFont(
                        fontName: .nunitoSansExtraBold,
                        size: .h5
                    ))
                    .lineLimit(1)
                    .foregroundStyle(titleColor)
                    .tint(titleColor)
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
            }
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .padding(.horizontal, 50)
    }
}

#Preview {
    RoundedLargeButton(title: "Button title") {
        print("tapped")
    }
}
