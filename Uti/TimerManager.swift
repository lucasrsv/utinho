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

    private var utiStore: UtiStore?
    private var statisticsTimer: Timer?
    private var stateTimer: Timer?
    
    private let hourMs: Double = 3600
    private let dayMs: Double = 4*3600
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func didEnterBackground() {
        statisticsTimer?.invalidate()
        statisticsTimer = nil
        stateTimer?.invalidate()
        stateTimer = nil
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
    
    // TODO: This code could be simplified in just one function
    private func startStatisticsTimer() {
        var timeInterval: TimeInterval?
        let timeSpentSinceLastStatisticsTimerTick = Date().timeIntervalSince1970 - lastStatisticsTimerTickTimestamp
    
        if (timeSpentSinceLastStatisticsTimerTick >= hourMs) {
            let hoursSpentSinceLastLaunch = floor(timeSpentSinceLastStatisticsTimerTick/hourMs)
            utiStore?.updateUtiStatistics(hoursSpent: hoursSpentSinceLastLaunch)
            utiStore?.updateUtiState()
            timeInterval = timeSpentSinceLastStatisticsTimerTick.truncatingRemainder(dividingBy: hourMs)
        } else {
            timeInterval = hourMs - timeSpentSinceLastStatisticsTimerTick
        }
        
        statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval!, repeats: false) { [weak self] _ in
            self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
            self?.utiStore?.updateUtiState()
            self?.lastStatisticsTimerTickTimestamp = Date().timeIntervalSince1970
            timeInterval = self?.hourMs
            self?.statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval!, repeats: true) { [weak self]
                _ in
                self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                self?.utiStore?.updateUtiState()
                self?.lastStatisticsTimerTickTimestamp = Date().timeIntervalSince1970
            }
        }
    }
    
    private func startStateTimer() {
        var timeInterval: TimeInterval?
        let timeSpentSinceLastStateTimerTick = Date().timeIntervalSince1970 - lastStateTimerTickTimestamp
        
        if (timeSpentSinceLastStateTimerTick >= dayMs) {
            let daysSpentSinceLastLaunch = floor(timeSpentSinceLastStateTimerTick/dayMs)
            utiStore?.updateUtiPhase(elapsedTimeH: Int(daysSpentSinceLastLaunch))
            utiStore?.updateUtiState()
            timeInterval = dayMs - (Double(timeSpentSinceLastStateTimerTick) - (dayMs * daysSpentSinceLastLaunch))
        } else {
            timeInterval = dayMs - timeSpentSinceLastStateTimerTick
        }
        
        stateTimer = Timer.scheduledTimer(withTimeInterval: timeInterval!, repeats: false) { [weak self] _ in
            self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
            self?.utiStore?.updateUtiState()
            self?.lastStateTimerTickTimestamp = Date().timeIntervalSince1970
            timeInterval = self?.dayMs
            self?.stateTimer = Timer.scheduledTimer(withTimeInterval: timeInterval!, repeats: true) { [weak self] _ in
                self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
                self?.utiStore?.updateUtiState()
                self?.lastStateTimerTickTimestamp = Date().timeIntervalSince1970
            }
        }
    }
}
