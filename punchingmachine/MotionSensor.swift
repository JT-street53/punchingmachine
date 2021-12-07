//
//  MotionCensor.swift
//  punchingmachine
//
//  Created by Shelshoker on 2021/12/01.
//

import Foundation
import CoreMotion
import SwiftUI

class MotionSensor: NSObject, ObservableObject {
    
    @Published var isStarted = false
    
    @Published var xStr = "0.0"
    @Published var yStr = "0.0"
    @Published var zStr = "0.0"
    
    @Published var punch_score: Double = 0.0
    
    @Published var accelx: Array<Double> = Array(repeating:0.0, count:40)
    @Published var accely: Array<Double> = Array(repeating:0.0, count:40)
    @Published var accelz: Array<Double> = Array(repeating:0.0, count:40)
    
    let motionManager = CMMotionManager()
    
    func start() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.05
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                self.updateMotionData(deviceMotion: motion!)
            })
        }
        isStarted = true
    }
    
    func stop() {
        isStarted = false
        motionManager.stopDeviceMotionUpdates()
    }
    
    func score() {
        let t_array = stride(from: -1, to: 1, by: 0.05)
        let weigt_t = t_array.map { exp( -10.0 * pow($0, 2)) }
        let x2 = self.accelx.map { pow($0, 2) }
        let y2 = self.accely.map { pow($0, 2) }
        let z2 = self.accelz.map { pow($0, 2) / 4 }
        let vector_xyz = zip(zip(x2,y2).map(+), z2).map(+)
        self.punch_score = zip(weigt_t, vector_xyz).map(*).max() ?? 0
        self.punch_score *= 2
    }
    
    private func updateMotionData(deviceMotion:CMDeviceMotion) {
        let x = deviceMotion.userAcceleration.x
        let y = deviceMotion.userAcceleration.y
        let z = deviceMotion.userAcceleration.z
        xStr = String(x)
        yStr = String(y)
        zStr = String(z)
        accelx.append(x)
        accelx.removeFirst()
        accely.append(y)
        accely.removeFirst()
        accelz.append(z)
        accelz.removeFirst()
    }
    
    private func weight_t(time:Double) -> Double {
        return exp( -10.0 * pow(time, 2))
    }
    
}
