//
//  TimerManager.swift
//  Uti
//
//  Created by lrsv on 18/06/23.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    @AppStorage("LastLaunchTimestamp") var lastLaunchTimestamp: TimeInterval = 0.0
    @EnvironmentObject private var utiStore: UtiStore
    
    private var timer: Timer?
    
    func startTimer() {
        var timeInterval: TimeInterval
        if (lastLaunchTimestamp != 0.0) {
            let timeSpentSinceLastLaunch = Date().timeIntervalSince1970 - lastLaunchTimestamp
            timeInterval = (timeSpentSinceLastLaunch < 3600) ? 3600 - timeSpentSinceLastLaunch : timeSpentSinceLastLaunch - 3600
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                self?.onTimerFire()
                timeInterval = TimeInterval(3600)
                self?.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self]
                    _ in
                    self?.onTimerFire()
                }
            }
        } else {
            timeInterval = TimeInterval(3600)
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
                self?.onTimerFire()
            }
        }
    }
    
    func onTimerFire() {
        utiStore.uti.health = utiStore.uti.blood - 2
        utiStore.uti.leisure = utiStore.uti.blood - 3
        utiStore.uti.nutrition = utiStore.uti.blood - 5
    }
    
}
