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
            network: NetworkManager? = RemoteConfigManager.sharedInstance
        ) {
            self.network = network
            self.coordinator = coordinator
            fetch()
        }
        
        // MARK: - Open
        func fetch() {
            network?.fetchDataFor(
                key: "json_data",
                decodeTo: Books.self
            ) { [weak self] result in
                
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self?.banners = success.topBannerSlides
                        self?.books = success.books?.compactMap { BookModel(book: $0) }
                        self?.recommendationIDs = success.youWillLikeSection
                        if let books = self?.books {
                            self?.sections = self?.getGroupedData(from: books)
                        }
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
            let temp = Dictionary(grouping: books, by: \.genre)
            return temp.keys.sorted().compactMap { key in
                if let values = temp[key] {
                    return CategoryModel(title: key, items: values)
                } else {
                    return nil
                }
            }
        }
    }
}
