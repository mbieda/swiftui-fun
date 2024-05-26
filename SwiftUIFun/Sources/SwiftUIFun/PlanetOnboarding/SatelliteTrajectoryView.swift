import SwiftUI

struct SatelliteTrajectoryView: View {
    struct Config: Hashable {
        let trajectoryColor: Color
        let width: CGFloat
    }
    
    let config: Config
    
    init(config: Config) {
        self.config = config
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(config.trajectoryColor, lineWidth: 2)
                .frame(width: config.width)
        }
    }
}

extension SatelliteTrajectoryView.Config {
    init(fromConfig config: SatelliteView.Config) {
        self.trajectoryColor = config.trajectoryColor
        self.width = config.width
    }
}

#Preview {
    SatelliteTrajectoryView(config: .init(
        trajectoryColor: .justPrimary,
        width: 200
    ))
}
