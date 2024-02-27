//
//  MainView.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

struct MainView: View {
    // MARK: - Properties
    @StateObject private var viewModel: ViewModel
    private let pageViewAspectRatio = 16 / 7.5
    private let sectionPadding: CGFloat = 20
    
    // MARK: - Initialization
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - View
    var body: some View {
        List {
            Group {
                pageView
                    .padding(16)
                
                if let sections = viewModel.sections {
                    ForEach(sections) { section in
                        if !section.items.isEmpty {
                            CategoryRow(section: section) { book in
                                viewModel.onSelect(book: book)
                            }
                            .padding(.top, sectionPadding)
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .refreshable {
            await viewModel.fetch()
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Text("Library")
                    .font(.customFont(
                        fontName: .nunitoSansBold,
                        size: .h3
                    ))
                    .foregroundStyle(.pinkDark)
            }
        }
        .navigationTitle("")
    }
       
    // MARK: - Private
    @ViewBuilder
    private var pageView: some View {
        if let banners = viewModel.banners {
            PageView(
                pages: banners.map { BannerItemView(banner: $0) },
                currentPageIndicatorTintColor: .pinkDark
            ) { selectedIndex in
                viewModel.onSelectBanner(index: selectedIndex)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .aspectRatio(pageViewAspectRatio, contentMode: .fit)
        } else {
            ZStack {
                Color.grayCustom
                LoaderView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .aspectRatio(pageViewAspectRatio, contentMode: .fit)
        }
    }
}

#Preview {
    NavigationStack {
        MainView(viewModel: .init(coordinator: Coordinator()))
    }
}
