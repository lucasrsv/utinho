//
//  NotificationManager.swift
//  Uti
//
//  Created by michellyes on 08/09/23.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    func requestNotificationPermission(completion: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }
    
    func scheduleDailyNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Título da Notificação"
        content.body = "Corpo da Notificação"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 39
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print("Erro ao agendar a notificação: \(error.localizedDescription)")
            } else {
                print("Notificação agendada com sucesso!")
            }
        }
    }
    
}
