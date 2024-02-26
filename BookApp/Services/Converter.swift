//
//  Converter.swift
//  BookApp
//
//  Created by Anton Shvets on 25.02.2024.
//

import Foundation

enum Converter {
    static func getStatisticBarModelsFrom(book: any Book) -> [StatisticBarModel] {
        var result: [StatisticBarModel] = []
        
        if let views = book.views {
            result.append(.init(title: views, subtitle: "Readers"))
        }
        if let likes = book.likes {
            result.append(.init(title: likes, subtitle: "Likes"))
        }
        if let quotes = book.quotes {
            result.append(.init(title: quotes, subtitle: "Quotes"))
        }

        result.append(.init(title: book.genre, subtitle: "Genre"))
        
        return result
    }
}
