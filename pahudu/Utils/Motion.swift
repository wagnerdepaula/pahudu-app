//
//  Motion.swift
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
