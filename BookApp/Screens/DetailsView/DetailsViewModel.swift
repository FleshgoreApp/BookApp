//
//  DetailsViewModel.swift
//  BookApp
//
//  Created by Anton Shvets on 22.02.2024.
//

import SwiftUI

extension DetailsView {
    
    final class ViewModel: ObservableObject {
        // MARK: - Properties
        private var coordinator: Coordinator
        private(set) var selectedBook: any Book
        private let recommendationIDs: [Int]?
        private(set) var lastIndex: Int = 0
        
        private weak var network: NetworkManager?
        
        @Published var books: [any Book]?
        @Published var recommendationSection: CategoryModel?
        @Published var statisticBarItems: [StatisticBarModel]?
        
        // MARK: - Initialization
        init(
            coordinator: Coordinator,
            book: any Book, recommendationIDs: [Int]?,
            network: NetworkManager? = RemoteConfigManager.shared
        ) {
            self.coordinator = coordinator
            self.network = network
            self.selectedBook = book
            self.recommendationIDs = recommendationIDs
            self.statisticBarItems = book.statisticBarItems
            fetch()
        }
        
        // MARK: - Open
        func fetch() {
            network?.fetchDataFor(
                key: "details_carousel",
                decodeTo: CarouselDetails.self
            ) { [weak self] result in
                
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        
                        var temp = success.books
                        
                        if let index = temp?.firstIndex(where: { $0.id == self?.selectedBook.id }),
                           let book = temp?.remove(at: index) {
                            
                            temp?.insert(book, at: .zero)
                        }
                        
                        self?.books = temp?.compactMap { BookModel(book: $0) }
                        
                        self?.recommendationSection = self?.getRecommendations(ids: self?.recommendationIDs, books: self?.books)
                    }
                case .failure(let failure):
                    switch failure {
                    case .decodeError:
                        print(failure.errorDescription) //Handle error
                    case .remoteConfigFetchError:
                        print(failure.errorDescription) //Handle error
                    }
                }
            }
        }
        
        func onIndexChanged(_ index: Int) {
            guard lastIndex != index else { return }
            
            if let book = books?[safe: index] {
                selectedBook = book
                statisticBarItems = book.statisticBarItems
                lastIndex = index
            }
        }
        
        func onBackButtonTapped() {
            coordinator.pop()
        }
        
        // MARK: - Private
        private func getRecommendations(ids: [Int]?, books: [any Book]?) -> CategoryModel? {
            guard let ids, let books else { return nil }
            return .init(
                title: "You will also like",
                items: books.filter { ids.contains($0.id ?? 0) }
            )
        }
    }
}
