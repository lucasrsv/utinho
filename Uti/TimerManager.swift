//
//  TimerManager.swift
//  Uti
//
//  Created by lrsv on 18/06/23.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    @AppStorage("LastLaunchTimestamp") var lastLaunchTimestamp: TimeInterval = Date().timeIntervalSince1970
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
        if (lastLaunchTimestamp != 0.0) {
            let timeSpentSinceLastLaunch = Date().timeIntervalSince1970 - lastLaunchTimestamp
            
            if (timeSpentSinceLastLaunch > 3600) {
                let hoursSpentSinceLastLaunch = Int(floor(timeSpentSinceLastLaunch/3600))
                utiStore?.updateUtiStatistics(hoursSpent: hoursSpentSinceLastLaunch)
                utiStore?.updateUtiState()
                print("tinha timer spent since last launch e atualizou state")
                timeInterval =  timeSpentSinceLastLaunch.truncatingRemainder(dividingBy: 3600)
            } else {
                timeInterval = 3600 - timeSpentSinceLastLaunch
            }
            
            statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                timeInterval = TimeInterval(3600)
                self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                self?.utiStore?.updateUtiState()
                self?.statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self]
                    _ in
                    self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                    self?.utiStore?.updateUtiState()
                    print("entrou no statistics timer 1")
                }
            }
        } else {
            timeInterval = TimeInterval(3600)
            statisticsTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
                self?.utiStore?.updateUtiStatistics(hoursSpent: 1)
                self?.utiStore?.updateUtiState()
                print("entrou no statistics timer 2")
            }
        }
    }
    
    private func startStateTimer() {
        let currentDate = Date()
        let calendar = Calendar.current
        let nextMidnight = currentDate + (4 * 3600)
        let timeInterval = nextMidnight.timeIntervalSince(currentDate)
        
        if let lastLaunchDate = getDate(from: lastLaunchTimestamp) {
            print(lastLaunchTimestamp)
            let elapsedTime = calendar.dateComponents([.hour], from: lastLaunchDate, to: currentDate)
            print(elapsedTime.hour!)
            if (elapsedTime.hour != nil && elapsedTime.hour! >= 4) {
                utiStore?.updateUtiPhase(elapsedTimeH: elapsedTime.hour!)
                utiStore?.updateUtiState()
                print("entrou no state timer 1")
            }
            stateTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
                self?.utiStore?.updateUtiState()
                print("entrou no state timer 2")
                self?.stateTimer = Timer.scheduledTimer(withTimeInterval: (4*3600), repeats: false) { [weak self] _ in
                    self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
                    self?.utiStore?.updateUtiState()
                    print("entrou no state timer 3")
                }
            }
        } else {
            stateTimer = Timer.scheduledTimer(withTimeInterval: (4*3600), repeats: false) { [weak self] _ in
                self?.utiStore?.updateUtiPhase(elapsedTimeH: 4)
                self?.utiStore?.updateUtiState()
                print("entrou no state timer 4")
            }
        }
    }
    
    private func getDate(from timestamp: TimeInterval) -> Date? {
        return Date(timeIntervalSince1970: timestamp)
    }
}
