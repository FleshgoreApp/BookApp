//
//  BooksEntity.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import Foundation

// MARK: - Books -
struct Books: Codable {
    let books: [BookEntity]?
    let topBannerSlides: [Banner]?
    let youWillLikeSection: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case books
        case topBannerSlides = "top_banner_slides"
        case youWillLikeSection = "you_will_like_section"
    }
}

// MARK: - BookEntity -
struct BookEntity: Codable {
    let id: Int?
    let name: String?
    let author: String?
    let summary: String?
    var genre: String = "Genre"
    let coverUrl: String?
    let views: String?
    let likes: String?
    let quotes: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, author, summary, genre, views, likes, quotes
        case coverUrl = "cover_url"
    }
}

// MARK: - Banner -
struct Banner: Codable, Identifiable {
    let id: Int?
    let bookId: Int?
    let cover: String?
    
    enum CodingKeys: String, CodingKey {
        case id, cover
        case bookId = "book_id"
    }
}
