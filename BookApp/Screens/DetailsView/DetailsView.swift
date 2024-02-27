//
//  DetailsView.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

struct DetailsView: View {
    // MARK: - Properties
    @StateObject private var viewModel: ViewModel
    
    // MARK: - Initialization
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - View
    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height + geo.safeAreaInsets.bottom
            
            BottomSheetDrawer(minHeight: height/2.5) {
                content
            } bgContent: {
                carousel
                    .background(.purpleCustom)
            }
        }
    }
    
    // MARK: - Private
    private var carousel: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                
                ZStack {
                    bgImage
                    bgColor
                    gradient
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .ignoresSafeArea(.all, edges: .top)
                
                if let books = viewModel.books {
                    let containerHeight = geo.size.height/1.61
                    let cellWidth = containerHeight * 0.45
                    let cellHeight = hasHomeButton ? containerHeight * 0.5 : containerHeight * 0.62
                    
                    ZStack {
                        Carousel(
                            itemWidth: cellWidth,
                            views: books.compactMap { book in
                                CarouselItem {
                                    BookCard(book: book,
                                             size: .init(
                                                width: cellWidth,
                                                height: cellHeight
                                             )
                                    )
                                }
                            }) { index in
                                viewModel.onIndexChanged(index)
                            }
                    }
                    .frame(width: geo.size.width, height: containerHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
    }
    
    private var bgImage: some View {
        VStack {
            Image("detailsBG")
                .resizable()
                .scaledToFill()
                .opacity(0.3)
        }
    }
    
    private var bgColor: some View {
        Color.black
            .opacity(0.7)
    }
    
    private var gradient: some View {
        LinearGradient(
            colors: [
                .init(hex: "140D1400"),
                .init(hex: "140D1400"),
                .init(hex: "302A31D9"),
                .black
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .opacity(0.3)
    }
    
    private var content: some View {
        VStack(spacing: .zero) {
            Group {
                statisticBar
                    .padding(.vertical, 12)
                    .animation(.none, value: UUID())
                Divider()
                HStack {
                    summery
                        .padding(.vertical, 16)
                    Spacer()
                }
                Divider()
            }
            .padding(.horizontal, 16)
            
            recommendationsSlider
                .padding(.vertical, 16)
            
            RoundedLargeButton(
                title: "Read Now",
                backgroundColor: .pinkLight
            ) {
                print("Rounded button tapped")
            }
            .padding(.top, 16)
        }
    }
    
    @ViewBuilder
    private var statisticBar: some View {
        if let items = viewModel.statisticBarItems {
            StatisticBarView(items: items)
        }
    }
    
    @ViewBuilder
    private var summery: some View {
        if let summery = viewModel.selectedBook.summary {
            VStack(alignment: .leading, spacing: 5) {
                Text("Summery")
                    .font(.customFont(
                        fontName: .nunitoSansBold,
                        size: .h3
                    ))
                    .foregroundStyle(.mainText)
                Text(summery)
                    .font(.customFont(
                        fontName: .nunitoSansSemiBold,
                        size: .h5
                    ))
                    .foregroundStyle(.mainText2)
            }
        }
    }
    
    @ViewBuilder
    private var recommendationsSlider: some View {
        if let section = viewModel.recommendationSection {
            CategoryRow(section: section)
        }
    }
}

#Preview {
    DetailsView(viewModel: .init(
        coordinator: Coordinator(),
        book: CategoryItemSample.sample.first!,
        recommendationIDs: [2,3,5]
    ))
}
