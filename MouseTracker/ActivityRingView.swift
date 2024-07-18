import SwiftUI

struct ActivityRingView: View {
    var progress: Double
    var color: Color
    var icon: String
    var ringWidth: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(color.opacity(0.2), lineWidth: ringWidth)
                Circle()
                    .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                    .stroke(color, style: StrokeStyle(lineWidth: ringWidth, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Image(systemName: icon)
                    .font(.system(size: ringWidth * 0.6))
                    .foregroundColor(.white)
                    .offset(y: -geometry.size.width / 2)
                    .rotationEffect(.degrees(360 * progress - 2))
                    .animation(.linear, value: progress)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .animation(.linear, value: progress)
    }
}
