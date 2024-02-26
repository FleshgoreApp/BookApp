//
//  SplashView.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

struct SplashView: View {
    // MARK: - Properties
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    private let totalValue: Double = 100
    
    @State private var currentValue: Double = 0
    
    // MARK: - View
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                background
                
                VStack(spacing: .zero) {
                    Group {
                        Spacer()
                        
                        title
                        
                        subTitle
                            .padding(.top, 10)
                        
                        progressView
                            .padding(.top, 50)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                }
                .frame(width: geo.size.width)
            }
            .ignoresSafeArea(edges: [.top, .bottom])
        }
    }
    
    // MARK: - Private
    private var background: some View {
        Group {
            Image("bg")
                .resizable()
                .scaledToFill()
            Image("bgHeart")
                .resizable()
                .scaledToFit()
        }
    }
    
    private var title: some View {
        Text("Book App")
            .font(.customFont(
                fontName: .georgiaItalicBold,
                customSize: 52
            ))
            .foregroundStyle(.pinkLight)
    }
    
    private var subTitle: some View {
        Text("Welcome to Book App")
            .font(.customFont(
                fontName: .nunitoSansBold,
                size: .h1
            ))
            .foregroundStyle(.white)
    }
    
    private var progressView: some View {
        ProgressView(value: currentValue, total: totalValue)
            .progressViewStyle(ProgressBarStyle())
            .onReceive(timer) { _ in
                if currentValue < totalValue {
                    currentValue += 0.5
                }
            }
    }
}

#Preview {
    SplashView()
}
