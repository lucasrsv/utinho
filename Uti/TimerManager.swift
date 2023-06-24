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
    
    private var statisticsTimer: Timer?
    private var stateTimer: Timer?
    
    init() {
        startStatisticsTimer()
        startStateTimer()
    }
    
    private func startStatisticsTimer() {
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
            
            statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                timeInterval = TimeInterval(3600)
                self?.updateUtiStatistics(hoursSpent: 1)
                self?.statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self]
                    _ in
                    self?.updateUtiStatistics(hoursSpent: 1)
                }
            }
        } else {
            timeInterval = TimeInterval(3600)
            statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
                self?.updateUtiStatistics(hoursSpent: 1)
            }
        }
    }
    
    private func startStateTimer() {
        let currentDate = Date()
        let calendar = Calendar.current
        let nextMidnight = calendar.startOfDay(for: currentDate) + (24 * 3600)
        let timeInterval = nextMidnight.timeIntervalSince(currentDate)
        
        if let lastLaunchDate = getDate(from: lastLaunchTimestamp) {
            let elapsedTime = calendar.dateComponents([.hour], from: lastLaunchDate, to: currentDate)
            if (elapsedTime.hour != nil && elapsedTime.hour! >= 24) {
                updateUtiState(elapsedTimeH: elapsedTime.hour!)
            }
            stateTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                self?.updateUtiState(elapsedTimeH: 24)
                self?.stateTimer = Timer.scheduledTimer(withTimeInterval: (24*3600), repeats: false) { [weak self] _ in
                    self?.updateUtiState(elapsedTimeH: 24)
                }
            }
        } else {
            stateTimer = Timer.scheduledTimer(withTimeInterval: (24*3600), repeats: false) { [weak self] _ in
                self?.updateUtiState(elapsedTimeH: 24)
            }
        }
    }
    
    private func updateUtiState(elapsedTimeH: Int) {
        utiStore.uti.currentCycleDay = (utiStore.uti.currentCycleDay < 28) ? utiStore.uti.currentCycleDay + elapsedTimeH/24 : 1 + (elapsedTimeH/24 - 1)
        if (utiStore.uti.currentCycleDay <= 5) {
            utiStore.uti.phase = .menstrual
        } else if (utiStore.uti.currentCycleDay >= 6 && utiStore.uti.currentCycleDay <= 11) {
            utiStore.uti.phase = .folicular
        } else if (utiStore.uti.currentCycleDay >= 12 && utiStore.uti.currentCycleDay <= 16) {
            utiStore.uti.phase = .fertile
        } else {
            utiStore.uti.phase = .luteal
        }
    }
    
    private func updateUtiStatistics(hoursSpent: Int) {
        utiStore.uti.health = utiStore.uti.blood - (2 * hoursSpent)
        utiStore.uti.leisure = utiStore.uti.blood - (3 * hoursSpent)
        utiStore.uti.nutrition = utiStore.uti.blood - (5 * hoursSpent)
    }
    
    private func getDate(from timestamp: TimeInterval) -> Date? {
        return Date(timeIntervalSince1970: timestamp)
    }
}
