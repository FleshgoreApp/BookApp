//
//  PageView.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI

/*
 Pager operating logic:
 1) When the user holds his finger on the picture for a long time, the autoscrolling (timer) stops.
 2) When the user removes his finger from the picture, we turn on the timer.
 3) When the user flips through pages, after each action we set a pause equal to 3 timer intervals.
*/

struct PageView<Page: View>: View {
    // MARK: - Properties
    private var pages: [Page]
    private var currentPageIndicatorTintColor: Color
    private var pageIndicatorTintColor: Color
    private var controlBottomPadding: CGFloat
    private var onSelectPage: ((Int) -> ())?
    
    @State private var timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    @State private var pauseInterval = 0
    @State private var currentPage: Int = 0
    @State private var isDisappeared = false
    
    // MARK: - Initialization
    init(pages: [Page],
         currentPageIndicatorTintColor: Color,
         pageIndicatorTintColor: Color = .grayCustom,
         controlBottomPadding: CGFloat = .zero,
         onSelectPage: ((Int) -> Void)? = nil
    ) {
        self.pages = pages
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        self.pageIndicatorTintColor = pageIndicatorTintColor
        self.controlBottomPadding = controlBottomPadding
        self.onSelectPage = onSelectPage
    }
    
    // MARK: - View
    var body: some View {
        ZStack(alignment: .bottom) {
            PageViewController(
                pages: pages,
                currentPage: $currentPage
            )
            .gesture(DragGesture(minimumDistance: 12)
                .onChanged { _ in
                    // add a pause after moving to another element (7..9 seconds)
                    pauseInterval = 3
                }
            )
            .onTapGesture {
                onSelectPage?(currentPage)
            }
            .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: handlePressing, perform: {})
            
            PageControl(
                numberOfPages: pages.count,
                currentPageIndicatorTintColor: currentPageIndicatorTintColor,
                pageIndicatorTintColor: pageIndicatorTintColor,
                currentPage: $currentPage
            )
            .padding(.bottom, controlBottomPadding)
        }
        .onReceive(timer) { _ in
            guard !isDisappeared && pauseInterval == 0 else {
                pauseInterval -= 1
                return
            }
            if currentPage < pages.count - 1 {
                currentPage += 1
            } else {
                currentPage = .zero
            }
        }
        .onAppear {
            isDisappeared = false
        }
        .onDisappear {
            isDisappeared = true
        }
    }
    
    //MARK: - Timer long press logic
    private func handlePressing(_ isPressed: Bool) {
        guard !isPressed else { 
            cancelTimer()
            return
        }
        restartTimer()
    }
    
    private func cancelTimer() {
        timer.upstream.connect().cancel()
    }
    
    private func restartTimer() {
        timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    }
}

#Preview {
    PageView(
        pages: PageViewSample.sample,
        currentPageIndicatorTintColor: .pinkDark
    )
    .aspectRatio(3 / 2, contentMode: .fit)
}
