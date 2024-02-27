//
//  RemoteConfig.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import FirebaseRemoteConfig
import Foundation

final class RemoteConfigManager: NetworkManager {
    // MARK: - Properties
    static let shared = RemoteConfigManager()
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    // MARK: - Initialization
    private init() {
        setup()
    }
    
    // MARK: - NetworkManager protocol
    func fetchDataFor<D: Decodable>(key: String, decodeTo: D.Type) async throws -> D {
        let status = try await remoteConfig.fetch()
        guard status == .success else {
            throw RCError.remoteConfigFetchError
        }
        
        let _ = try await remoteConfig.activate()
        
        let rcValue = RemoteConfig.remoteConfig().configValue(forKey: key).dataValue
        
        do {
            let response = try JSONDecoder().decode(D.self, from: rcValue)
            return response
        } catch {
            throw RCError.decodeError
        }
    }
    
    // MARK: - Private
    private func setup() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
}
