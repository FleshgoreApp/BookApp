//
//  CategoryItemSample.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import Foundation

enum CategoryItemSample {
    static let sample: [any Book] = [
        BookEntity(id: 322, name: "A Beta Before an Alpha", author: "Author", summary: "According to researchers at Duke University, habits account for about 40 percent of our behaviors on any given day. Your life today is essentially the sum of your habits. How in shape or out of shape you are? A result of your habits. How happy or unhappy you are? A result of your habits. How successful or unsuccessful you are? A result of your habits.", genre: "Romance", coverUrl: "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg", views: "22.2k", likes: "40k", quotes: "32.5k"),
        BookEntity(id: 2655462, name: "Prince Reagan", author: "Author", summary: "", genre: "", coverUrl: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D", views: "", likes: "", quotes: ""),
        BookEntity(id: 86546, name: "Hangry Wolf With His Queen", author: "Author", summary: "", genre: "", coverUrl: "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=", views: "", likes: "", quotes: ""),
        BookEntity(id: 9786754, name: "Devili’s Night Bride", author: "Author", summary: "", genre: "", coverUrl: "https://i.pinimg.com/736x/ed/ea/69/edea6915cf09f7d850819f034c9d2ffd.jpg", views: "", likes: "", quotes: "")
    ].compactMap { BookModel(book: $0) }
}
