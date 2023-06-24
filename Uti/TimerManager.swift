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
    
    private func startTimer() {
        var timeInterval: TimeInterval
        if (lastLaunchTimestamp != 0.0) {
            let timeSpentSinceLastLaunch = Date().timeIntervalSince1970 - lastLaunchTimestamp
            if (timeSpentSinceLastLaunch > 3600) {
                let hoursSpentSinceLastLaunch = Int(floor(timeSpentSinceLastLaunch/3600))
                updateUtiStatistics(hoursSpent: hoursSpentSinceLastLaunch)
                timeInterval =  timeSpentSinceLastLaunch.truncatingRemainder(dividingBy: 3600)
            } else {
                timeInterval = 3600 - timeSpentSinceLastLaunch
            }
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                timeInterval = TimeInterval(3600)
                self?.updateUtiStatistics(hoursSpent: 1)
                self?.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self]
                    _ in
                    self?.updateUtiStatistics(hoursSpent: 1)
                }
            }
        } else {
            timeInterval = TimeInterval(3600)
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
                self?.updateUtiStatistics(hoursSpent: 1)
            }
        }
    }
    
    private func updateUtiStatistics(hoursSpent: Int) {
        utiStore.uti.health = utiStore.uti.blood - (2 * hoursSpent)
        utiStore.uti.leisure = utiStore.uti.blood - (3 * hoursSpent)
        utiStore.uti.nutrition = utiStore.uti.blood - (5 * hoursSpent)
    }
    
}
