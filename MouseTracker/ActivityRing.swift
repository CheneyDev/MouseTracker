import SwiftUI

struct ActivityRing: Identifiable {
    let id = UUID()
    var progress: Double
    var goal: Double
    var color: Color
    var icon: String
    var unit: String
}
