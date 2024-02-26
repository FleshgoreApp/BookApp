//
//  CachedImage.swift
//  AsyncImageStarter
//

import SwiftUI

struct CachedImage<Content: View>: View {
    // MARK: - Properties
    @StateObject private var manager = CachedImageManager()
    let url: String
    let animation: Animation?
    let transition: AnyTransition
    let content: (AsyncImagePhase) -> Content
    
    // MARK: - Initialization
    init(url: String,
         animation: Animation? = nil,
         transition: AnyTransition = .identity,
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.animation = animation
        self.transition = transition
        self.content = content
    }
    
    // MARK: - View
    var body: some View {
        ZStack {
            switch manager.currentState {
            case .loading:
                content(.empty)
                    .transition(transition)
            case .success(let data):
                if let image = UIImage(data: data) {
                    content(.success(Image(uiImage: image)))
                        .transition(transition)
                } else {
                    content(.failure(CachedImageError.invalidData))
                        .transition(transition)
                }
            case .failed(let error):
                content(.failure(error))
                    .transition(transition)
            default:
                content(.empty)
                    .transition(transition)
            }
        }
        .animation(animation, value: manager.currentState)
        .task {
            await manager.load(url)
        }
    }
}

#Preview {
    let url = "https://images.unsplash.com/photo-1621155346337-1d19476ba7d6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGltYWdlfGVufDB8fDB8fHww"
    
    return CachedImage(url: url) { phase in
        
        if let image = phase.image {
            image
                .resizable()
                .scaledToFill()
        } else if phase.error != nil {
            ImagePlaceholder()
        } else {
            LoaderView()
        }
    }
    .frame(width: 200, height: 300)
    .clipped()
}

// MARK: - CachedImageError
extension CachedImage {
    enum CachedImageError: Error {
        case invalidData
    }
}
