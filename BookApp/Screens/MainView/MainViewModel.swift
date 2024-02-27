//
//  MainViewModel.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI
    
extension MainView {
    
    final class ViewModel: ObservableObject {
        // MARK: - Properties
        private var coordinator: Coordinator
        private var books: [any Book]?
        private var recommendationIDs: [Int]?
        private weak var network: NetworkManager?
        
        @Published var banners: [Banner]?
        @Published var sections: [CategoryModel]?
        
        // MARK: - Initialization
        init(
            coordinator: Coordinator,
            network: NetworkManager? = RemoteConfigManager.shared
        ) {
            self.network = network
            self.coordinator = coordinator
            
            // Fetch data asynchronously
            Task {
                await fetch()
            }
        }
        
        // MARK: - Open
        @MainActor
        func fetch() async {
            do {
                let data = try await network?.fetchDataFor(key: "json_data", decodeTo: Books.self)
                
                self.banners = data?.topBannerSlides
                self.books = data?.books?.compactMap { BookModel(book: $0) }
                self.recommendationIDs = data?.youWillLikeSection
                if let books = self.books {
                    self.sections = self.getGroupedData(from: books)
                }
            } catch {
                if let error = error as? RCError {
                    switch error {
                    case .decodeError, .remoteConfigFetchError:
                        print(error.errorDescription) // Handle error
                    }
                }
            }
        }
        
        func onSelect(book: any Book) {
            coordinator.push(page: .details(book: book, recommendationIDs: recommendationIDs))
        }
        
        func onSelectBanner(index: Int) {
            guard let bookID = banners?[safe: index]?.bookId,
                  let book = books?.first(where: { $0.id == bookID })
            else {
                return
            }
            onSelect(book: book)
        }
        
        // MARK: - Private
        private func getGroupedData(from books: [any Book]) -> [CategoryModel]? {
            return Dictionary(grouping: books, by: { $0.genre ?? "Genre" })
                .compactMap { key, values in
                    CategoryModel(title: key, items: values)
                }
        }
    }
}
