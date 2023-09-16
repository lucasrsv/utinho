//
//  NotificationManager.swift
//  Uti
//
//  Created by michellyes on 08/09/23.
//

import SwiftUI
import UserNotifications
import Combine

class NotificationManager {
    private var cancellables = Set<AnyCancellable>()
    private var uti: Uti
    private let notificationTitles: [String] = ["notification_title1", "notification_title2", "notification_title3", "notification_title4", "notification_title5", "notification_title6", "notification_title7" ]
    private let notificationBodies: [String] = ["notification_body1", "notification_body2", "notification_body3", "notification_body4", "notification_body5", "notification_body6", "notification_body7" ]
    
    init(uti: Uti) {
        self.uti = uti
        
        requestNotificationPermission { granted in
            if granted {
                self.scheduleDailyNotification()
                self.uti.phasePublisher
                    .sink { newPhase in
                        self.sendPhaseNotification(newPhase: newPhase)
                    }
                    .store(in: &self.cancellables)
            }
        }
    }
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                //TODO: Handle this error
                print(error)
                completion(false)
            } else {
                completion(granted)
            }
        }
    }
    
    func scheduleDailyNotification() {
        let notificationIndex = Int.random(in: 0 ..< notificationTitles.count)
        let center = UNUserNotificationCenter.current()
        let title = LocalizedStringKey(notificationTitles[notificationIndex])
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString(notificationTitles[notificationIndex], comment: "")
        content.body = NSLocalizedString(notificationBodies[notificationIndex], comment: "")
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 36
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print("Erro ao agendar a notificação diária: \(error.localizedDescription)")
            } else {
                print("Notificação agendada com sucesso!")
            }
        }
    }
    
    func sendPhaseNotification(newPhase: Phase) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Utinho Update"
        content.body = "O Utinho está agora na fase \(newPhase)!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "phaseChangeNotification", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print("Erro ao enviar a notificação de update: \(error.localizedDescription)")
            } else {
                print("Notificação enviada com sucesso!")
            }
        }
    }
    
}
