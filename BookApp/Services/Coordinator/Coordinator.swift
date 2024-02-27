//
//  Coordinator.swift
//  BookApp
//
//  Created by Anton Shvets on 22.02.2024.
//

import SwiftUI

enum Page: Hashable, Identifiable {
    case main
    case details(book: any Book, recommendationIDs: [Int]?)
    
    var id: String {
        switch self {
        case .main: "main"
        case .details: "details"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .main:
            hasher.combine("main")
        case let .details(book, recommendationIDs):
            hasher.combine("details")
            hasher.combine(book)
            hasher.combine(recommendationIDs)
        }
    }
    
    static func == (lhs: Page, rhs: Page) -> Bool {
        switch (lhs, rhs) {
        case (.main, .main): return true
        case let (.details(lhsBook, lhsRecommendationIDs), .details(rhsBook, rhsRecommendationIDs)):
            return lhsBook.id == rhsBook.id && lhsRecommendationIDs == rhsRecommendationIDs
        default:
            return false
        }
    }
}

final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .main:
            MainView(viewModel: .init(coordinator: self))
        case let .details(book, recommendationIDs):
            DetailsView(viewModel: .init(
                coordinator: self,
                book: book,
                recommendationIDs: recommendationIDs
            ))
        }
    }
}
