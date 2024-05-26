import SwiftUI

struct SatelliteConfigProducer {
    private typealias Constants = PlanetConstants.Satellite
    
    private func widthForSatellite(count: Int) -> CGFloat {
        (Constants.satelliteMaxRadius - Constants.satelliteMinRadius) / CGFloat(count)
    }
    
    private func degrees(index: Int, direction: RotationDirection) -> CGFloat {
        if index < Constants.initialStartRadiansOptions.count {
            return Constants.initialStartRadiansOptions[index]
        } else {
            return randomDegrees(for: direction)
        }
    }
    
    private func randomDegrees(for direction: RotationDirection) -> CGFloat {
        switch direction {
        case .counterClockwise:
            return CGFloat.random(in: Constants.counterClocwiseDegressRange)
        case .clockwise:
            return CGFloat.random(in: Constants.clocwiseDegressRange)
        }
    }
    
    func produce(for config: PlanetConfig, index: Int, totalCount: Int) -> SatelliteView.Config {
        .init(
            color: config.satelliteColor,
            trajectoryColor: Constants.trajectoryColor,
            width: Constants.satelliteMinRadius + CGFloat(index) * widthForSatellite(count: totalCount),
            startDegrees: degrees(
                index: index,
                direction: (index % 2 == 0) ? .clockwise : .counterClockwise
            ),
            endDegrees: Constants.endDegrees,
            direction: (index % 2 == 0) ? .clockwise : .counterClockwise
        )
    }
}
