//
//  TimerManager.swift
//  Uti
//
//  Created by lrsv on 18/06/23.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    @AppStorage("LastStaticsTimerTickTimestamp") private var lastStatisticsTimerTickTimestamp: TimeInterval?
    @AppStorage("LastStateTimerTickTimestamp") private var lastStateTimerTickTimestamp: TimeInterval?

    private var utiStore: UtiStore?
    private var statisticsTimer: Timer?
    private var stateTimer: Timer?
    
    private let hourS: Double = 3600
    private let dayS: Double = 14400
    
    init() {
        if (lastStatisticsTimerTickTimestamp == nil) {
            lastStatisticsTimerTickTimestamp = Date().timeIntervalSince1970
        }
        if (lastStateTimerTickTimestamp == nil) {
            lastStateTimerTickTimestamp = Date().timeIntervalSince1970
        }
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
        NSLog("UTINHOLOG: lastStatisticsTimerTickTimestamp \(lastStatisticsTimerTickTimestamp!)")
        var timeInterval: TimeInterval?
        let timeSpentSinceLastStatisticsTimerTick = Date().timeIntervalSince1970 - lastStatisticsTimerTickTimestamp!
        if (timeSpentSinceLastStatisticsTimerTick >= hourS) {
            let hoursSpentSinceLastLaunch = floor(timeSpentSinceLastStatisticsTimerTick/hourS)
            utiStore?.updateUtiStatistics(hoursSpent: hoursSpentSinceLastLaunch)
            utiStore?.updateUtiState()
            lastStatisticsTimerTickTimestamp = lastStatisticsTimerTickTimestamp! + (hoursSpentSinceLastLaunch * hourS)
//            timeInterval = timeSpentSinceLastStatisticsTimerTick.truncatingRemainder(dividingBy: hourS)
            timeInterval = hourS - (Double(timeSpentSinceLastStatisticsTimerTick) - (hourS * hoursSpentSinceLastLaunch))
        } else {
            timeInterval = hourS - timeSpentSinceLastStatisticsTimerTick
        }

        statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval!, repeats: false) { [weak self] _ in
            self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
            self?.utiStore?.updateUtiState()
            self?.lastStatisticsTimerTickTimestamp = Date().timeIntervalSince1970
            timeInterval = self?.hourS
            self?.statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval!, repeats: true) { [weak self]
                _ in
                self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                self?.utiStore?.updateUtiState()
                self?.lastStatisticsTimerTickTimestamp = Date().timeIntervalSince1970
            }
        }
    }
    
    private func startStateTimer() {
        NSLog("UTINHOLOG: lastStateTimerTickTimestamp \(lastStateTimerTickTimestamp!)")
        var timeInterval: TimeInterval?
        let timeSpentSinceLastStateTimerTick = Date().timeIntervalSince1970 - lastStateTimerTickTimestamp!
        if (timeSpentSinceLastStateTimerTick >= dayS) {
            let daysSpentSinceLastLaunch = floor(timeSpentSinceLastStateTimerTick/dayS)
            NSLog("UTINHOLOG: daysSpentSinceLastLaunch \(daysSpentSinceLastLaunch)")
            utiStore?.updateUtiPhase(elapsedDays: Int(daysSpentSinceLastLaunch))
            utiStore?.updateUtiState()
            lastStateTimerTickTimestamp = lastStateTimerTickTimestamp! + (daysSpentSinceLastLaunch * dayS)
            timeInterval = dayS - (Double(timeSpentSinceLastStateTimerTick) - (dayS * daysSpentSinceLastLaunch))
            NSLog("UTINHOLOG: updated lastStateTimerTickTimestamp \(lastStateTimerTickTimestamp!)")
        } else {
            timeInterval = dayS - timeSpentSinceLastStateTimerTick
        }

        stateTimer = Timer.scheduledTimer(withTimeInterval: timeInterval!, repeats: false) { [weak self] _ in
            self?.utiStore?.updateUtiPhase(elapsedDays: 1)
            self?.utiStore?.updateUtiState()
            self?.lastStateTimerTickTimestamp = Date().timeIntervalSince1970
            timeInterval = self?.dayS
            self?.stateTimer = Timer.scheduledTimer(withTimeInterval: timeInterval!, repeats: true) { [weak self] _ in
                self?.utiStore?.updateUtiPhase(elapsedDays: 1)
                self?.utiStore?.updateUtiState()
                self?.lastStateTimerTickTimestamp = Date().timeIntervalSince1970
            }
        }
    }
}
