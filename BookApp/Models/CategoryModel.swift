//
//  CategoryModel.swift
//  BookApp
//
//  Created by Anton Shvets on 22.02.2024.
//

import Foundation

struct CategoryModel: Identifiable {
    let id = UUID()
    let title: String
    let items: [any Book]
}
