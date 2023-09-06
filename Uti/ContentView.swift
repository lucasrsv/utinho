//
//  ContentView.swift
//  Uti
//
//  Created by lrsv on 12/06/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @EnvironmentObject private var utiStore: UtiStore
    @StateObject private var timerManager: TimerManager = TimerManager()
    @State private var isPopupVisible = false
    
    
    var body: some View {
        ZStack{
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        ZStack {
                            VStack() {
                                PhaseCycleCircle(uti: utiStore.uti)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .onTapGesture {
                                isPopupVisible.toggle()
                            }
                            VStack {
                                StateBar(uti: utiStore.uti, category: .health)
                                StateBar(uti: utiStore.uti, category: .nutrition)
                                StateBar(uti: utiStore.uti, category: .leisure)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.bottom, Responsive.scale(s: Spacing.small))
                }
                UtiView()
                    .environmentObject(utiStore)
                
                Button("Request Permission") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
                
                Button("Schedule Notification") {
                    let content = UNMutableNotificationContent()
                    content.title = "Eu vou morrer de fome"
                    content.body = "Faz 6 dias que tu num me alimenta bicho... pelo amor de deus!"
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
                
                
            }
            .onAppear {
                timerManager.setup(utiStore: utiStore)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.all, Responsive.scale(s: Spacing.large))
            .background(
                Image("standard_background")
                    .resizable()
                    .ignoresSafeArea()
            )
            
            if isPopupVisible {
                CycleChangePopupView(isPopupVisible: $isPopupVisible, uti: utiStore.uti)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static func getUtiStore() -> UtiStore {
        let utiStore: UtiStore = UtiStore()
        utiStore.uti = Uti(currentCycleDay: 2, phase: .luteal, state: .sleepy, illness: .no, leisure: 50, health: 50, nutrition: 70, energy: 100, blood: 100, items: [])
        return utiStore
    }
    
    static var previews: some View {
        ContentView()
            .environmentObject(getUtiStore())
    }
}
