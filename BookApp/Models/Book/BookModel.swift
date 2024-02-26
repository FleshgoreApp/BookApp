//
//  BookModel.swift
//  BookApp
//
//  Created by Anton Shvets on 26.02.2024.
//

import Foundation

struct BookModel: Book {
    let id: Int?
    let name: String?
    let author: String?
    let summary: String?
    var genre: String
    let coverUrl: String?
    let views: String?
    let likes: String?
    let quotes: String?
    var statisticBarItems: [StatisticBarModel]? {
        Converter.getStatisticBarModelsFrom(book: self)
    }
    
    init(book: BookEntity) {
        self.id = book.id
        self.name = book.name
        self.author = book.author
        self.summary = book.summary
        self.genre = book.genre 
        self.coverUrl = book.coverUrl
        self.views = book.views
        self.likes = book.likes
        self.quotes = book.quotes
    }
}
