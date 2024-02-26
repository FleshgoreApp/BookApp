//
//  StatisticBarModel.swift
//  BookApp
//
//  Created by Anton Shvets on 24.02.2024.
//

import Foundation

struct StatisticBarModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
