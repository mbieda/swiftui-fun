import SwiftUI

extension View {
    public var hasNotch: Bool {
        UIDevice.current.hasNotch
    }
    
    public var topInset: CGFloat {
        UIDevice.current.safeArea.top
    }
    
    public var bottomInset: CGFloat {
        UIDevice.current.safeArea.bottom
    }
    
    public var statusBarSize: CGSize {
        UIDevice.current.statusBarSize
    }
    
    public var screenSize: CGSize {
        UIDevice.current.screenSize
    }
    
    public var className: String {
        String(describing: type(of: self))
    }
    
    public func isHidden(_ hidden: Bool) -> some View {
        opacity(hidden ? 0 : 1)
    }
    
    public func squareFrame(size: CGFloat) -> some View {
        frame(width: size, height: size)
    }
}
