//
//  Converter.swift
//  BookApp
//
//  Created by Anton Shvets on 25.02.2024.
//

import Foundation

enum Converter {
    struct StatisticType {
        static let types: [(key: KeyPath<any Book, String?>, subtitle: String)] = [
            (\.views, "Readers"),
            (\.likes, "Likes"),
            (\.quotes, "Quotes"),
            (\.genre, "Genre")
        ]
    }

    static func getStatisticBarModelsFrom(book: any Book) -> [StatisticBarModel] {
        return StatisticType.types.compactMap { type in
            if let value = book[keyPath: type.key] {
                return StatisticBarModel(title: value, subtitle: type.subtitle)
            } else {
                return nil
            }
        }
    }
}
