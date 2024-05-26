import SwiftUI

struct ArrowView: View {
    
    let color: Color
    let height: CGFloat
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: height / 2))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: rectWidth, y: height))
            path.addLine(to: CGPoint(x: rectWidth + width, y: height / 2))
            path.addLine(to: CGPoint(x: rectWidth, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
        .fill(color)
    }
    
    var width: CGFloat {
        height * sqrt(2) / 2
    }
    
    var rectWidth: CGFloat {
        height / 3
    }
}

#Preview {
    ArrowView(color: .yellow, height: 100)
}
