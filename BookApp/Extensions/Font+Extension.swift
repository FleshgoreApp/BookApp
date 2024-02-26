//
//  Font+Extension.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

// MARK: - Font methods
extension Font {
    static func customFont(
        fontName: CustomFonts,
        size: CustomFontSize? = nil,
        customSize: CGFloat? = nil
    ) -> Font {
        return Font.custom(fontName.rawValue, size: customSize ?? size?.rawValue ?? 16)
    }
}

// MARK: - CustomFonts enum
enum CustomFonts: String {
    case nunitoSansSemiBold = "NunitoSans-SemiBold"
    case nunitoSansBold = "NunitoSans-Bold"
    case nunitoSansExtraBold = "NunitoSans-ExtraBold"
    case georgiaItalicBold = "Georgia Bold Italic"
}

// MARK: - CustomFontSize enum
enum CustomFontSize: CGFloat {
    ///CGFloat: 36
    case h0 = 36.0
    ///CGFloat: 24
    case h1 = 24.0
    ///CGFloat: 22
    case h2 = 22.0
    ///CGFloat: 20
    case h3 = 20.0
    ///CGFloat: 18
    case h4 = 18.0
    ///CGFloat: 16
    case h5 = 16.0
    ///CGFloat: 14
    case h6 = 14.0
}
