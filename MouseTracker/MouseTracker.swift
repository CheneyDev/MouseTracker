//
//  MouseTracker.swift
//  MouseTracker
//
//  Created by Cheney Wang on 7/17/24.
//

import Foundation
import AppKit

class MouseTracker: ObservableObject {
    @Published var distance: Double = 0
    private var lastPosition: NSPoint?
    private var timer: Timer?
    
    func resetDistance() {
            distance = 0
        }
    
    init() {
        startTracking()
    }
    
    private func startTracking() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.updateDistance()
        }
    }
    
    private func updateDistance() {
        let currentPosition = NSEvent.mouseLocation
        if let lastPosition = lastPosition {
            let dx = currentPosition.x - lastPosition.x
            let dy = currentPosition.y - lastPosition.y
            let moveDistance = sqrt(dx*dx + dy*dy)
            distance += moveDistance
        }
        lastPosition = currentPosition
    }
}
