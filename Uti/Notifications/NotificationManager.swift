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
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Estou com saudades e com fome!"
        content.body = "Você me abandonou um dia inteirinho 😭 Isso não se faz!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 10

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
