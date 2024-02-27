//
//  BookProtocol.swift
//  BookApp
//
//  Created by Anton Shvets on 26.02.2024.
//

import Foundation

protocol Book: Identifiable, Hashable {
    var id: Int? { get }
    var name: String? { get }
    var author: String? { get }
    var summary: String? { get }
    var genre: String? { get }
    var coverUrl: String? { get }
    var views: String? { get }
    var likes: String? { get }
    var quotes: String? { get }
    var statisticBarItems: [StatisticBarModel]? { get }
}
