//
//  Utils.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/9/24.
//

import SwiftUI
import CoreMotion


// Usage
// .offset(x: motionManager.roll * 10, y: motionManager.pitch * 10)
//    .onAppear {
//        motionManager.startMonitoringMotionUpdates()
//    }

class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var roll: CGFloat = 0.0
    @Published var pitch: CGFloat = 0.0
    
    func startMonitoringMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
            guard let motion = motion, error == nil else { return }
            self?.roll = CGFloat(motion.attitude.roll)
            self?.pitch = CGFloat(motion.attitude.pitch)
        }
    }
    
    func stopMonitoringMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}



func cleanURL(_ urlString: String) -> String {
    var cleanString = urlString
    if cleanString.hasPrefix("http://") {
        cleanString = String(cleanString.dropFirst("http://".count))
    } else if cleanString.hasPrefix("https://") {
        cleanString = String(cleanString.dropFirst("https://".count))
    }
    if cleanString.hasPrefix("www.") {
        cleanString = String(cleanString.dropFirst("www.".count))
    }
    return cleanString
}




extension UIApplication {
    static func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}


enum ViewMode: CaseIterable {
    case grid, list
    
    var iconName: String {
        switch self {
        case .grid: return "circle.grid.3x3.fill"
        case .list: return "rectangle.grid.1x2.fill"
        }
    }
}


