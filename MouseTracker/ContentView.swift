import SwiftUI

struct ContentView: View {
    @StateObject private var mouseTracker = MouseTracker()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            titleSection
            activityRings
            travelInfoSection
            resetButton
        }
        .padding()
        .frame(width: 240, height: 430)
        .background(backgroundColor)
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color(NSColor.windowBackgroundColor) : Color.white
    }
    
    private var titleSection: some View {
        Text("Mouse Travel")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.primary)
            .padding(.top, 2)
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)
    }
    
    private var activityRings: some View {
        ZStack {
            ActivityRingView(
                progress: min(mouseTracker.distance / 40000, 1.0),
                color: .blue,
                icon: "camera.macro.circle"
            )
            .frame(width: 150, height: 150)
            
            ActivityRingView(
                progress: min(mouseTracker.distance / 50000 , 1.0),
                color: .green,
                icon: "figure.walk.motion"
            )
            .frame(width: 110, height: 110)
            
            ActivityRingView(
                progress: min(mouseTracker.distance / 63360, 1.0),
                color: .red,
                icon: "figure.highintensity.intervaltraining"
            )
            .frame(width: 70, height: 70)
        }
    }
    
    private var travelInfoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            travelInfoRow(
                value: Int(mouseTracker.distance),
                unit: "pixels",
                color: .blue,
                icon: "camera.macro.circle",
                valueFontSize: 28,
                unitFontSize: 16
            )
            
            travelInfoRow(
                value: Int(mouseTracker.distance * 0.0254),
                unit: "cm",
                color: .green,
                icon: "figure.walk.motion",
                valueFontSize: 20,
                unitFontSize: 14
            )
            
            travelInfoRow(
                value: String(format: "%.2f", mouseTracker.distance / 63360),
                unit: "miles",
                color: .red,
                icon: "figure.highintensity.intervaltraining",
                valueFontSize: 20,
                unitFontSize: 14
            )
        }
    }
    
    private var resetButton: some View {
        Button(action: {
            mouseTracker.resetDistance()
        }) {
            Text("Reset")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(BorderlessButtonStyle())
        .controlSize(.large)
        .background(buttonBackgroundColor)
        .foregroundColor(buttonForegroundColor)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(buttonBorderColor, lineWidth: 0.5)
        )
        .padding(.top, 10)
        .frame(width: 80, height: 40)
    }
    
    private var buttonBackgroundColor: Color {
        colorScheme == .dark ? Color(NSColor.controlBackgroundColor).opacity(0.5) : Color(NSColor.controlBackgroundColor)
    }
    
    private var buttonForegroundColor: Color {
        colorScheme == .dark ? .white : .primary
    }
    
    private var buttonBorderColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.2) : Color(NSColor.separatorColor)
    }
    
    private func travelInfoRow(value: CustomStringConvertible, unit: String, color: Color, icon: String, valueFontSize: CGFloat, unitFontSize: CGFloat) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 20))
                .frame(width: 20, alignment: .center)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value.description)
                    .font(.system(size: valueFontSize, weight: .bold))
                    .foregroundColor(color)
                Text(unit)
                    .font(.system(size: unitFontSize, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
    }
}
