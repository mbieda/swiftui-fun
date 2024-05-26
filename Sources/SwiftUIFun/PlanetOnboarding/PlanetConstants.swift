import SwiftUI

enum PlanetConstants {
    
    enum Satellite {
        static let satelliteMinRadius: CGFloat = 120
        static let satelliteMaxRadius: CGFloat = 300
        static let initialStartRadiansOptions: [CGFloat] = [-135, 90, -180, 45]
        static let endDegrees: CGFloat = -45
        static let trajectoryColor: Color = .justWhite
        static let clocwiseDegressRange: ClosedRange<CGFloat> = (-224 ... -90)
        static let counterClocwiseDegressRange: ClosedRange<CGFloat> = (0 ... 134)
    }
}

extension Color {
    static let justBlack: Self = .init(red: 46/255, green: 46/255, blue: 46/255)
    static let justWhite: Self = .init(red: 254/255, green: 254/255, blue: 254/255)
    static let justPrimary: Self = .init(red: 9/255, green: 26/255, blue: 86/255)
    
    static let onPink: Self = .init(red: 245/255, green: 157/255, blue: 166/255)
    static let onLightBlue: Self = .init(red: 128/255, green: 179/255, blue: 253/255)
    static let onBlue: Self = .init(red: 39/255, green: 82/255, blue: 187/255)
    static let onDarkBlue: Self = .init(red: 9/255, green: 26/255, blue: 86/255)
}
