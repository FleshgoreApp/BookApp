//
//  BottomSheetDrawer.swift
//  BookApp
//
//  Created by Anton Shvets on 23.02.2024.
//

import SwiftUI

struct BottomSheetDrawer<Content: View, BGContent: View>: View {
    // MARK: - Properties
    @State private var offset: CGFloat = .zero
    @State private var lastOffset: CGFloat = .zero
    @GestureState private var gestureOffset: CGFloat = .zero
    @State private var isExpanded = false
    
    private var minHeight: CGFloat = 100
    private let scrollTopViewID = "scrollTopViewID"
    private var scrollViewBottomPadding: CGFloat {
        hasHomeButton ? 8 : 32
    }
    
    @ViewBuilder private var content: () -> Content
    @ViewBuilder private var bgContent: () -> BGContent
    
    // MARK: - Initialization
    init(minHeight: CGFloat,
         content: @escaping () -> Content,
         bgContent: @escaping () -> BGContent
    ) {
        self.minHeight = minHeight
        self.content = content
        self.bgContent = bgContent
    }
    
    // MARK: - View
    var body: some View {
        
        ZStack {
            // MARK: - BGContent -
            bgContent()
            
            // Drawer View
            GeometryReader { geo -> AnyView in
                let height = geo.frame(in: .global).height
                
                return AnyView (
                    ZStack {
                        VStack {
                            Color(.systemBackground)
                        }
                        .roundedCorner(20, corners: [.topLeft, .topRight])
                        
                        VStack {
                            // MARK: - Drag button -
                            dragButton
                            
                            ScrollViewReader { reader in
                                ScrollView {
                                    EmptyView()
                                        .id(scrollTopViewID)
                                    // MARK: - Content -
                                    content()
                                        .onChange(of: isExpanded) { _ in
                                            withAnimation {
                                                reader.scrollTo(
                                                    scrollTopViewID,
                                                    anchor: .top
                                                )
                                            }
                                        }
                                    Color.clear
                                        .frame(height: scrollViewBottomPadding)
                                }
                                .scrollIndicators(.hidden)
                                .scrollDisabled(!isExpanded)
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .offset(y: height - minHeight)
                    .offset(y: offset(height))
                    .gesture(
                        gesture(height)
                    )
                )
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    // MARK: - Private
    private func offset(_ height: CGFloat) -> CGFloat {
        -offset > 0 ? -offset <= (height - minHeight) ? offset : -(height - minHeight) : 0
    }
    
    private func gesture(_ height: CGFloat) -> some Gesture {
        DragGesture()
            .updating(
                $gestureOffset,
                body: { value, out, _ in
                    out = value.translation.height
                    onChangeDrag()
                })
            .onEnded { value in
                let maxHeight = height - minHeight
                
                withAnimation {
                    
                    //FULL + UP
                    if value.startLocation.y > 0 && value.location.y < 0 {
                        offset = -maxHeight
                    }
                    //MIN
                    else if -lastOffset == maxHeight {
                        offset = .zero
                    }
                    //FULL
                    else if -offset > 40 {
                        offset = -maxHeight
                    }
                    //DEFAULT
                    else {
                        offset = .zero
                    }
                    
                    isExpanded = offset != .zero
                    lastOffset = offset
                }
            }
    }
    
    private func onChangeDrag() {
        DispatchQueue.main.async {
            offset = gestureOffset + lastOffset
        }
    }
    
    private var dragButton: some View {
        Capsule()
            .fill(.purpleCustom)
            .frame(width: 60, height: 5)
            .padding(.top, 5)
            .opacity(isExpanded ? 1 : 0)
    }
}

#Preview {
    BottomSheetDrawer(minHeight: 400) {
        VStack(alignment: .leading, spacing: 5) {
            Text("Summery")
                .font(.customFont(fontName: .nunitoSansBold, size: .h3))
                .foregroundStyle(.mainText)
            Text("According to researchers at Duke University, habits account for about 40 percent of our behaviors on any given day. Your life today is essentially the sum of your habits. How in shape or out of shape you are? A result of your habits. How happy or unhappy you are? A result of your habits. How successful or unsuccessful you are? A result of your habits.")
                .font(.customFont(fontName: .nunitoSansSemiBold, size: .h5))
                .foregroundStyle(.mainText2)
        }
        .padding()
    } bgContent: {
        GeometryReader { geo in
            VStack {
                PageView(
                    pages: PageViewSample.sample,
                    currentPageIndicatorTintColor: .pinkDark
                )
            }
            .frame(height: geo.size.height/2.5)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 16)
        }
        .background(.purpleCustom)
    }
}

// MARK: - Initialization
extension BottomSheetDrawer where BGContent == EmptyView {
    init(
        minHeight: CGFloat,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            minHeight: minHeight,
            content: content,
            bgContent: { EmptyView() }
        )
    }
}
