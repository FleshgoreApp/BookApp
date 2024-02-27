//
//  ImageRetriever.swift
//  AsyncImageStarter
//

import Foundation

struct ImageRetriever {
    enum RetrieverError: Error {
        case invalidURL
        case networkError(Error)
        case noData
    }
    
    func fetch(_ imgUrl: String) async throws -> Data {
        guard let url = URL(string: imgUrl) else {
            throw RetrieverError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard !data.isEmpty else {
                throw RetrieverError.noData
            }
            return data
        } catch {
            throw RetrieverError.networkError(error)
        }
    }
}
