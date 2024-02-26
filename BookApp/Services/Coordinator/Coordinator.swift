//
//  Coordinator.swift
//  BookApp
//
//  Created by Anton Shvets on 22.02.2024.
//

import SwiftUI

enum Page: Hashable, Identifiable {
    static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    case main
    case details(book: any Book, recommendationIDs: [Int]?)
    
    var id: String {
        switch self {
        case .main: "main"
        case .details: "details"
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
