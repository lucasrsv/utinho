//
//  TimerManager.swift
//  Uti
//
//  Created by lrsv on 18/06/23.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    @AppStorage("LastStaticsTimerTickTimestamp") private var lastStatisticsTimerTickTimestamp: TimeInterval = Date().timeIntervalSince1970
    @AppStorage("LastStateTimerTickTimestamp") private var lastStateTimerTickTimestamp: TimeInterval = Date().timeIntervalSince1970
    @Published var elapsedTimeInBackground: TimeInterval = 0
    
    private var cameFromBackground: Bool = false
    private var backgroundEnterTime: Date?
    private var utiStore: UtiStore?
    private var statisticsTimer: Timer?
    private var stateTimer: Timer?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func didEnterBackground() {
        statisticsTimer?.invalidate()
        statisticsTimer = nil
        stateTimer?.invalidate()
        stateTimer = nil
        cameFromBackground = true
    }
    
    @objc private func willEnterForeground() {
        startStatisticsTimer()
        startStateTimer()
    }
    
    func setup(utiStore: UtiStore) {
        self.utiStore = utiStore
        startStatisticsTimer()
        startStateTimer()
    }
    
    private func startStatisticsTimer() {
        var timeInterval: TimeInterval
        
        if (lastStatisticsTimerTickTimestamp != 0.0 || cameFromBackground) {
            cameFromBackground = false
            let timeSpentSinceLastStatisticsTimerTick = Date().timeIntervalSince1970 - lastStatisticsTimerTickTimestamp
            
            if (timeSpentSinceLastStatisticsTimerTick > 3600) {
                let hoursSpentSinceLastLaunch = Int(floor(timeSpentSinceLastStatisticsTimerTick/3600))
                utiStore?.updateUtiStatistics(hoursSpent: hoursSpentSinceLastLaunch)
                utiStore?.updateUtiState()
                timeInterval = timeSpentSinceLastStatisticsTimerTick.truncatingRemainder(dividingBy: 3600)
            } else {
                timeInterval = 3600 - timeSpentSinceLastStatisticsTimerTick
            }
            
            statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                self?.utiStore?.updateUtiState()
                self?.lastStatisticsTimerTickTimestamp = Date().timeIntervalSince1970
                timeInterval = TimeInterval(3600)
                self?.statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self]
                    _ in
                    self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                    self?.utiStore?.updateUtiState()
                    self?.lastStatisticsTimerTickTimestamp = Date().timeIntervalSince1970
                }
            }
        } else {
            timeInterval = TimeInterval(3600)
            statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
                self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                self?.utiStore?.updateUtiState()
                self?.lastStatisticsTimerTickTimestamp = Date().timeIntervalSince1970
            }
        }
    }
    
    private func startStateTimer() {
        let currentDate = Date()
        let calendar = Calendar.current
        let nextMidnight = currentDate + (4 * 3600)
        var timeInterval = nextMidnight.timeIntervalSince(currentDate)
        
        
        if (lastStateTimerTickTimestamp != 0.0 || cameFromBackground) {
            cameFromBackground = false
            let lastLaunchDate = getDate(from: lastStateTimerTickTimestamp)
            let elapsedTime = calendar.dateComponents([.hour], from: lastLaunchDate, to: currentDate)
            if (elapsedTime.hour != nil && elapsedTime.hour! >= 4) {
                utiStore?.updateUtiPhase(elapsedTimeH: elapsedTime.hour!)
                utiStore?.updateUtiState()
            }
            stateTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
                self?.utiStore?.updateUtiState()
                self?.lastStateTimerTickTimestamp = Date().timeIntervalSince1970
                timeInterval = TimeInterval((4*3600))
                self?.stateTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
                    self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
                    self?.utiStore?.updateUtiState()
                    self?.lastStateTimerTickTimestamp = Date().timeIntervalSince1970
                }
            }
        } else {
            timeInterval = TimeInterval((4*3600))
            stateTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
                self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
                self?.utiStore?.updateUtiState()
                self?.lastStateTimerTickTimestamp = Date().timeIntervalSince1970
            }
        }
    }
    
    private func getDate(from timestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }
}
