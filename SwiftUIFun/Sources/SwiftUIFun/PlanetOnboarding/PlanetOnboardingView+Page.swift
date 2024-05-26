import SwiftUI

extension PlanetOnboardingView {
    
    struct PlanetPage: Hashable {
        let id = UUID()
        let backgroundColor: Color
        let title: String
        let satelliteConfig: SatelliteView.Config
    }
}
