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
    var uti: Uti
    
    init() {
        uti = Uti(currentCycleDay: 1, phase: .menstrual, state: .homelyHappy, illness: .no, leisure: 50, health: 60, nutrition: 55, energy: 100, blood: 100, items: [])
    }
    
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
        content.title = "Estou com saudades e com fome!"
        content.body = "Você me abandonou um dia inteirinho 😭 Isso não se faz!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 16
        dateComponents.minute = 17
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
    
    func sendPhaseNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Utinho Update"
        content.body = "O Utinho está agora na fase \(Uti.phaseText(phase: self.uti.phase))!"
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
