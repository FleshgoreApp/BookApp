//
//  Array+Extension.swift
//  BookApp
//
//  Created by Anton Shvets on 22.02.2024.
//

import Foundation

extension Array {
    public subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
