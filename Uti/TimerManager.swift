//
//  TimerManager.swift
//  Uti
//
//  Created by lrsv on 18/06/23.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    @AppStorage("LastStaticsTimerTickTimestamp") private var lastStaticsTimerTickTimestamp: TimeInterval = Date().timeIntervalSince1970
    @AppStorage("LastStateTimerTickTimestamp") private var lastStateTimerTickTimestamp: TimeInterval = Date().timeIntervalSince1970
    private var utiStore: UtiStore?
    private var statisticsTimer: Timer?
    private var stateTimer: Timer?
    
    func setup(utiStore: UtiStore) {
        self.utiStore = utiStore
        startStatisticsTimer()
        startStateTimer()
    }
    
    private func startStatisticsTimer() {
        var timeInterval: TimeInterval
        if (lastStaticsTimerTickTimestamp != 0.0) {
            let timeSpentSinceLastStaticsTimerTick = Date().timeIntervalSince1970 - lastStaticsTimerTickTimestamp
            
            if (timeSpentSinceLastStaticsTimerTick > 3600) {
                let hoursSpentSinceLastLaunch = Int(floor(timeSpentSinceLastStaticsTimerTick/3600))
                utiStore?.updateUtiStatistics(hoursSpent: hoursSpentSinceLastLaunch)
                utiStore?.updateUtiState()
                timeInterval =  timeSpentSinceLastStaticsTimerTick.truncatingRemainder(dividingBy: 3600)
            } else {
                timeInterval = 3600 - timeSpentSinceLastStaticsTimerTick
            }
            
            statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                timeInterval = TimeInterval(3600)
                self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                self?.utiStore?.updateUtiState()
                self?.lastStaticsTimerTickTimestamp = Date().timeIntervalSince1970
                self?.statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self]
                    _ in
                    self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                    self?.utiStore?.updateUtiState()
                    self?.lastStaticsTimerTickTimestamp = Date().timeIntervalSince1970
                }
            }
        } else {
            timeInterval = TimeInterval(3600)
            statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
                self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                self?.utiStore?.updateUtiState()
                self?.lastStaticsTimerTickTimestamp = Date().timeIntervalSince1970
            }
        }
    }
    
    private func startStateTimer() {
        let currentDate = Date()
        let calendar = Calendar.current
        let nextMidnight = currentDate + (4 * 3600)
        let timeInterval = nextMidnight.timeIntervalSince(currentDate)
        
        if let lastLaunchDate = getDate(from: lastStateTimerTickTimestamp) {
            let elapsedTime = calendar.dateComponents([.hour], from: lastLaunchDate, to: currentDate)
            if (elapsedTime.hour != nil && elapsedTime.hour! >= 4) {
                utiStore?.updateUtiPhase(elapsedTimeH: elapsedTime.hour!)
                utiStore?.updateUtiState()
            }
            stateTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
                self?.utiStore?.updateUtiState()
                self?.lastStateTimerTickTimestamp = Date().timeIntervalSince1970
                self?.stateTimer = Timer.scheduledTimer(withTimeInterval: (4*3600), repeats: false) { [weak self] _ in
                    self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
                    self?.utiStore?.updateUtiState()
                    self?.lastStateTimerTickTimestamp = Date().timeIntervalSince1970
                }
            }
        } else {
            stateTimer = Timer.scheduledTimer(withTimeInterval: (4*3600), repeats: false) { [weak self] _ in
                self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
                self?.utiStore?.updateUtiState()
            }
        }
    }
    
    private func getDate(from timestamp: TimeInterval) -> Date? {
        return Date(timeIntervalSince1970: timestamp)
    }
}
