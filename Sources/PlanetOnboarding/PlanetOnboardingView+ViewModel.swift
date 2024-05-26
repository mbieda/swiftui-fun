import SwiftUI

extension PlanetOnboardingView {
    @Observable final class ViewModel {
        
        private(set) var pages: [PlanetPage]
        
        init(pages: [PlanetPage]) {
            self.pages = pages
        }
        
        var currentPageIndex = 0 {
            didSet {
                if maxPageCompletedIndex < currentPageIndex - 1 {
                    maxPageCompletedIndex = currentPageIndex - 1
                }
            }
        }
        var maxPageCompletedIndex = -1
        
        var currentPage: PlanetPage {
            pages[currentPageIndex]
        }
        
        var previousPageIndex: Int? {
            guard currentPageIndex > 0 else { return nil }
            return currentPageIndex - 1
        }
        
        var nextPageIndex: Int? {
            guard currentPageIndex < pages.count - 1 else { return nil }
            return currentPageIndex + 1
        }
        
        func backgroundColor(for index: Int) -> Color {
            pages[index].backgroundColor
        }
        
        var currentBackgroundColor: Color {
            pages[currentPageIndex].backgroundColor
        }
        
        var previousBackgroundColor: Color? {
            guard let previousPageIndex else { return nil }
            return pages[previousPageIndex].backgroundColor
        }
        
        var nextBackgroundColor: Color? {
            guard let nextPageIndex else { return nil }
            return pages[nextPageIndex].backgroundColor
        }
        
        func percent(
            for page: PlanetPage,
            nextPageIndex: Int,
            duringSwipe: Bool,
            swipeProgress: CGFloat,
            swipeComplete: Bool
        ) -> CGFloat {
            guard !swipeComplete else { return 100 }
            guard let index = pages.firstIndex(of: page) else { return 0 }
            let percent: CGFloat
            if index <= maxPageCompletedIndex {
                percent = 100
            } else 
            if index < nextPageIndex - 1 {
                percent = 100
            } else if index == nextPageIndex - 1 {
                percent = swipeProgress > 0 ? (1 - swipeProgress) * 100 : 100
            } else if index == nextPageIndex {
                if duringSwipe {
                    return 0
                } else {
                    percent = swipeProgress < 0 ? (-swipeProgress * 100) : 0
                }
            } else {
                percent = 0
            }
            return max(0, min(100, percent))
        }
    }
}
