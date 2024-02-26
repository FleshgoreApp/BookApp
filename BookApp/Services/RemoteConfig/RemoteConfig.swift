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
    static let sharedInstance = RemoteConfigManager()
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    // MARK: - Open
    func setup() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    func fetchDataFor<D: Decodable>(key: String, decodeTo: D.Type, completion: @escaping (Result<D, RCError>) -> Void) {
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                self.remoteConfig.activate { _,_ in
                    let rcValue = RemoteConfig.remoteConfig().configValue(forKey: key)
                    let data = rcValue.dataValue
                    do {
                        let response = try JSONDecoder().decode(D.self, from: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                }
            } else {
                completion(.failure(.remoteConfigFetchError))
            }
        }
    }
}
