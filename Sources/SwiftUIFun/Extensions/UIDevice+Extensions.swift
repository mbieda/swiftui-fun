import UIKit

extension UIDevice {
    public var hasNotch: Bool {
        UIApplication.shared.window.safeAreaInsets.top > 20
    }

    public var safeArea: UIEdgeInsets {
        UIApplication.shared.window.safeAreaInsets
    }

    public var statusBarSize: CGSize {
        UIApplication.shared.window.windowScene?.statusBarManager?.statusBarFrame.size ?? .zero
    }

    public var screenSize: CGSize {
        UIApplication.shared.window.bounds.size
    }
}
