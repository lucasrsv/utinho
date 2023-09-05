//
//  OnboardingOne.swift
//  Uti
//
//  Created by michellyes on 30/08/23.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isButtonClicked = false
    @State private var buttonTextIndex = 0
    @State private var cycleOpacity: Double = 0.0
    @State private var levelsOpacity: Double = 0.0
    @State private var kitOpacity: Double = 0.0
    @State private var helloOpacity: Double = 1.0
    @State var showingSheet = false
    @State private var sheetHeight: CGFloat = .zero
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @AppStorage("IsFirstTime") var isFirstTime: Bool?
    @EnvironmentObject private var utiStore: UtiStore
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let onboardingTexts = [
        "Que bom que você está aqui! Vem me conhecer melhor!",
        "Obviamente eu sou um útero, e a partir de agora sua missão é cuidar de mim.",
        "Aqui tudo vai girar em torno do meu ciclo menstrual, que possui 28 dias :)",
        "Agora vou te mostrar tudo o que você vai precisar para cuidar de mim!",
        "É aqui que você vai acompanhar meus níveis de saúde, nutrição e lazer...",
        "Preste atenção neles para me manter saudável e feliz :)",
        "Aqui você vai saber em que dia e fase do ciclo eu estou...",
        "Isso vai ser importante, pois vai ter dias que não vou estar tão disposto...",
        "Ah! Cada dia do meu ciclo dura 4 horas. Isso quer dizer que 1 dia para você são 6 dias para mim.",
        "Esse é meu kit de sobrevivência...",
        "É com ele que você vai me alimentar, cuidar de mim e me divertir :)",
        "Agora é com você!"
    ]
    
    var currentOnboardingText: String {
        if buttonTextIndex >= onboardingTexts.count {
            return "Agora é com você!"
        } else {
            return onboardingTexts[buttonTextIndex]
        }
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            ZStack {
                                ZStack {
                                    VStack(alignment: .leading) {
                                        Text("Olá,")
                                        HStack {
                                            Text("sou")
                                            Text("Uti")
                                                .fontWeight(FontWeight.bold.value)
                                        }
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: Responsive.scale(s: FontSize.h0.rawValue)))
                                    .opacity(helloOpacity)
                                }
                                .padding(.trailing , UIScreen.main.bounds.size.width * 0.5)
                                
                                // cycle day
                                VStack() {
                                    VStack (spacing: 12) {
                                        ZStack {
                                            Circle()
                                                .strokeBorder(Color.beige, lineWidth: 12)
                                                .frame(width: 84, height: 84)
                                            Circle()
                                                .trim(from: 0, to: (CGFloat(1.0)/28))
                                                .stroke(
                                                    Color.lightBlue,
                                                    style: StrokeStyle (
                                                        lineWidth: 12
                                                    )
                                                )
                                                .padding(6)
                                                .frame(width: 84, height: 84)
                                                .rotationEffect(.degrees(-90))
                                            Text("1/28")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14, weight: .semibold))
                                        }
                                        Text("MENSTRUAL")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .semibold))
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .opacity(cycleOpacity)
                                
                                // horizontal progress bar
                                VStack {
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .frame(width: 64.0, height: 28.0)
                                            .foregroundColor(.beige).opacity(0.42)
                                        
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .frame(width: 32.0, height: 28.0)
                                            .foregroundColor(.lightBlue)
                                        
                                        HStack {
                                            Image("Health Icon")
                                        }
                                        .frame(width: 64.0, height: 28.0)
                                    }
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .frame(width: 64.0, height: 28.0)
                                            .foregroundColor(.beige).opacity(0.42)
                                        
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .frame(width: 32.0, height: 28.0)
                                            .foregroundColor(.lightBlue)
                                        
                                        HStack {
                                            Image("Food Icon")
                                        }
                                        .frame(width: 64.0, height: 28.0)
                                    }
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .frame(width: 64.0, height: 28.0)
                                            .foregroundColor(.beige).opacity(0.42)
                                        
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .frame(width: 32.0, height: 28.0)
                                            .foregroundColor(.lightBlue)
                                        
                                        HStack {
                                            Image("Party Icon")
                                        }
                                        .frame(width: 64.0, height: 28.0)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .opacity(levelsOpacity)
                            }
                        }
                        .padding(.bottom, Responsive.scale(s: Spacing.small))
                    }
                    VStack {
                        ZStack {
                            VStack {
                                Text(currentOnboardingText)
                                    .bold()
                                    .foregroundColor(.darkRed)
                                    .padding(.horizontal, 8)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.horizontal, 4.0)
                            .frame(minWidth: 330, idealWidth: 330, maxWidth: 330, minHeight: 80, idealHeight: 80, maxHeight: 100, alignment: .center)
                            .background(.white)
                            .cornerRadius(20.0)
                            
                            OnboardingButton(onButtonTap: {
                                // Ao clicar no botão, aumenta a opacidade gradualmente
                                buttonTextIndex += 1
                                if (buttonTextIndex == 3) {
                                    helloOpacity = 0.0
                                    levelsOpacity = 0.16
                                    cycleOpacity = 0.16
                                    kitOpacity = 0.16
                                } else if (buttonTextIndex == 4) {
                                    levelsOpacity = 1.0
                                } else if (buttonTextIndex == 6) {
                                    levelsOpacity = 0.16
                                    cycleOpacity = 1.0
                                } else if (buttonTextIndex == 9) {
                                    cycleOpacity = 0.16
                                    kitOpacity = 1.0
                                } else if (buttonTextIndex >= onboardingTexts.count) {
                                    navigationManager.navigate(to: .home)
                                }
                            }
                            )
                            .padding(.top, 100)
                            .padding(.leading, 200)
                        }
                        
                        VStack {
                            Image("happy")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.accentColor)
                            
                        }
                        Ellipse()
                            .foregroundColor(.strongRed)
                            .blur(radius: 20)
                            .frame(width: 150, height: 40)
                    }
                    
                    // survival kit
                    Button("Kit de Sobrevivência Uterina") {
                        showingSheet.toggle()
                    }
                    .frame(maxHeight: 100)
                    .multilineTextAlignment(.center)
                    .buttonStyle(CustomButtonStyle())
                    .fontWeight(.medium)
                    .opacity(kitOpacity)
                    
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.all, Responsive.scale(s: Spacing.large))
            .background(
                Image("standard_background")
                    .resizable()
                    .ignoresSafeArea()
            )
        }
        
        
    }
    
    struct CustomButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 2) // Borda branca
                        .background(Color.clear) // Fundo transparente
                )
                .foregroundColor(.white)
                .accentColor(.white)
        }
    }
    
    struct SheetKitPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}
//
//struct OnboardingOne_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingOne()
//    }
//}
