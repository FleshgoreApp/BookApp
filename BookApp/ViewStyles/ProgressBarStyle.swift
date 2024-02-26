//
//  ProgressBarStyle.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

struct ProgressBarStyle: ProgressViewStyle {
    var color: Color = .white
    var backgroundColor: Color = .white
    var backgroundOpacity: Double = 0.2
    var height: Double = 6.0
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundColor)
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .opacity(backgroundOpacity)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                    }
            }
        }
    }
}
