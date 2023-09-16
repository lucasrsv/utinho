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
        "onboarding_explanation0",
        "onboarding_explanation1",
        "onboarding_explanation2",
        "onboarding_explanation3",
        "onboarding_explanation4",
        "onboarding_explanation5",
        "onboarding_explanation6",
        "onboarding_explanation7",
        "onboarding_explanation8",
        "onboarding_explanation9",
        "onboarding_explanation10",
        "onboarding_explanation11"
    ]
    
    var currentOnboardingText: String {
        if buttonTextIndex >= onboardingTexts.count {
            return "onboarding_explanation11"
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
                                        Text("onboarding_firstHello0")
                                        HStack {
                                            Text("onboarding_firstHello1")
                                            Text("onboarding_firstHello2")
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
                    
                    Button("survivalKit_title") {
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
