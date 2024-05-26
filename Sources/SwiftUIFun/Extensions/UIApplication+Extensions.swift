import UIKit

extension UIApplication {
    var window: UIWindow {
        UIApplication.shared.connectedScenes
            .map {$0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter({ $0.isKeyWindow }).first
        ?? UIWindow()
    }
}
