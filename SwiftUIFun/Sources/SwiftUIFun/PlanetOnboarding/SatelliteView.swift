import SwiftUI

struct SatelliteView: View {
    struct Config: Hashable {
        let color: Color
        let trajectoryColor: Color
        let width: CGFloat
        let startDegrees: CGFloat
        let endDegrees: CGFloat
        let direction: RotationDirection
    }
    
    let config: Config
    let percent: CGFloat
    private let degressCalculator: DegreesCalculator
    
    init(config: Config, percent: CGFloat) {
        self.config = config
        self.percent = percent
        self.degressCalculator = .init(
            startDegrees: config.startDegrees,
            endDegrees: config.endDegrees,
            direction: config.direction
        )
    }
    
    var body: some View {
        ZStack {            
            Circle()
                .stroke(config.trajectoryColor.opacity(0.3), lineWidth: 2)
                .fill(config.color)
                .frame(width: 20)
                .shadow(
                    color: config.color,
                    radius: 5,
                    x: 2 * xOffset / config.width,
                    y: 2 * yOffset / config.width
                )
                .offset(x: xOffset, y: yOffset)
        }
        .frame(width: config.width)
    }
    
    private var xOffset: CGFloat {
        config.width / 2 * cos(degressCalculator.radiansForPercent(percent))
    }

    private var yOffset: CGFloat {
        config.width / 2 * sin(degressCalculator.radiansForPercent(percent))
    }
}

#Preview {
    struct PreviewView: View {
        @State var percent: CGFloat = 0
        
        @State var startRadians: CGFloat = 45
        @State var endRadians: CGFloat = -45
        @State var direction: RotationDirection = .counterClockwise
        
        var body: some View {
            VStack(spacing: 20) {
                VStack(spacing: .zero) {
                    Text("Percent: " + String(format: "%.02f", percent))
                    Slider(value: $percent, in: 0 ... 100)
                }
                
                VStack(spacing: .zero) {
                    Text("Start degrees: " + String(format: "%.02f", startRadians))
                    Slider(value: $startRadians, in: -180 ... 180)
                }
                
                VStack(spacing: .zero) {
                    Text("End degrees: " + String(format: "%.02f", endRadians))
                    Slider(value: $endRadians, in: -180 ... 180)
                }
            
                Picker("", selection: $direction) {
                    ForEach(RotationDirection.allCases, id: \.self) { direction in
                        Text(direction.name)
                    }
                }
                .pickerStyle(.segmented)
                
                let config: SatelliteView.Config = .init(
                    color: .justPrimary,
                    trajectoryColor: .justWhite,
                    width: 200,
                    startDegrees: startRadians,
                    endDegrees: endRadians,
                    direction: direction
                )
                ZStack {
                    SatelliteTrajectoryView(config: .init(fromConfig: config))
                    
                    SatelliteView(config: config, percent: percent)
                }
            }
            .padding()
            .background(Color.justPrimary.opacity(0.1))
        }
    }
    
    return PreviewView()
}

extension RotationDirection {
    var name: String {
        switch self {
        case .counterClockwise:
            "Counter clockwise"
        case .clockwise:
            "Clockwise"
        }
    }
}
