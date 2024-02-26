//
//  PageControl.swift
//  BookApp
//
//  Created by Anton Shvets on 21.02.2024.
//

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    var currentPageIndicatorTintColor: Color
    var pageIndicatorTintColor: Color
    
    @Binding var currentPage: Int
    
    //MARK: - UIViewRepresentable
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPageIndicatorTintColor = UIColor(currentPageIndicatorTintColor)
        control.pageIndicatorTintColor = UIColor(pageIndicatorTintColor)
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged
        )
        control.isUserInteractionEnabled = false
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}

//MARK: - PageControl Coordinator
extension PageControl {
    final class Coordinator: NSObject {
        var control: PageControl
        
        init(_ control: PageControl) {
            self.control = control
        }
        
        @objc
        func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
