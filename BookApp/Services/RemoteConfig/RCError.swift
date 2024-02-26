//
//  RCError.swift
//  BookApp
//
//  Created by Anton Shvets on 22.02.2024.
//

import Foundation

enum RCError: Error, LocalizedError {
    case decodeError
    case remoteConfigFetchError
    
    var errorDescription: String {
        switch self {
        case .decodeError: "Some description for decode error"
        case .remoteConfigFetchError: "Some description for remote config fetch error"
        }
    }
}
