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
    
    func scheduleNotification(/* Parâmetros para agendar a notificação */) {
            // Lógica para agendar uma notificação
    }
    
}
