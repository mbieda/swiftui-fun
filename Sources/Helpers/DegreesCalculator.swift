import Foundation

struct DegreesCalculator {
    let startDegrees: CGFloat
    let endDegrees: CGFloat
    let direction: RotationDirection
    
    func degreesForPercent(_ percent: CGFloat) -> CGFloat {
        let percent = percent / 100
        var degrees: CGFloat
        let percentOfDegreesDiff: CGFloat
        switch direction {
        case .counterClockwise:
            percentOfDegreesDiff = percent * (360 - (normalizedEndDegrees - startDegrees))
            degrees = startDegrees - percentOfDegreesDiff
        case .clockwise:
            percentOfDegreesDiff = percent * (normalizedEndDegrees - startDegrees)
            degrees = startDegrees + percentOfDegreesDiff
        }
        // normalize to meet the range of 0-359.(9)
        while degrees < 0 {
            degrees += 360
        }
        while degrees >= 360 {
            degrees -= 360
        }
        return degrees
    }
    
    func radiansForPercent(_ percent: CGFloat) -> CGFloat {
        return degreesForPercent(percent) * .pi / 180.0
    }
    
    private var normalizedEndDegrees: CGFloat {
        var normalizedEndDegrees = endDegrees
        while normalizedEndDegrees < startDegrees {
            normalizedEndDegrees += 360
        }
        return normalizedEndDegrees
    }
}
