//
//  CycleClockViewController.swift
//  Uti
//
//  Created by lrsv on 23/09/23.
//

import Foundation
import SwiftUI
import UIKit

struct CycleClockViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CycleClockViewController {
        return CycleClockViewController()
    }
    
    func updateUIViewController(_ uiViewController: CycleClockViewController, context: Context) {
        
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        return CycleClockViewControllerRepresentable()
    }
}

class CycleClockViewController: UIViewController {
    private var cycleClockView = CycleClockView()
    private var utiHour: Date?
    private var timer: Timer?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        setUtiHour()
        
        self.view.addSubview(cycleClockView)
        NSLayoutConstraint.activate([
            cycleClockView.topAnchor.constraint(equalTo: view.topAnchor),
            cycleClockView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cycleClockView.leftAnchor.constraint(equalTo: view.leftAnchor),
            cycleClockView.rightAnchor.constraint(equalTo: view.rightAnchor),
            cycleClockView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cycleClockView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
            self?.updateTimeLabel()
        }
        
        updateTimeLabel()
    }
    
    private func updateTimeLabel() {
        utiHour = utiHour?.addingTimeInterval(1.0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: utiHour!)
        cycleClockView.timeLabel.text = currentTime
        let hour = Calendar.current.component(.hour, from: utiHour!)
        
        if (hour > 5 && hour < 18) {
            cycleClockView.dayNightState = .day
        }
        else {
            cycleClockView.dayNightState = .night
        }
    }
    
    private func setUtiHour() {
        if let lastSavedDate = defaults.object(forKey: "utiHour") as? Date {
            let timeInterval: TimeInterval = Date().timeIntervalSince(lastSavedDate)*4
            utiHour = Date(timeIntervalSinceNow: timeInterval)
        } else {
            let now = Date.now
            defaults.set(now, forKey: "utiHour")
            utiHour = now
        }
    }
    
    @objc private func willEnterForeground() {
        setUtiHour()
    }
    
    deinit {
        timer?.invalidate()
        if let lastSavedDate = defaults.object(forKey: "utiHour") as? Date {
            let timeInterval: TimeInterval = Date().timeIntervalSince(lastSavedDate)*4
            defaults.set(Date(timeIntervalSinceNow: timeInterval), forKey: "utiHour")
        }
    }
    
}
