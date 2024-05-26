import SwiftUI

public struct PlanetConfig: Hashable {
    let backgroundColor: Color
    let title: String
    let satelliteColor: Color
    
    public init(backgroundColor: Color, title: String, satelliteColor: Color) {
        self.backgroundColor = backgroundColor
        self.title = title
        self.satelliteColor = satelliteColor
    }
}
