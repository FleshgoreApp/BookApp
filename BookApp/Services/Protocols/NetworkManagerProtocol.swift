//
//  NetworkManagerProtocol.swift
//  BookApp
//
//  Created by Anton Shvets on 26.02.2024.
//

import Foundation

protocol NetworkManager: AnyObject {
    func fetchDataFor<D: Decodable>(key: String, decodeTo: D.Type) async throws -> D
}
