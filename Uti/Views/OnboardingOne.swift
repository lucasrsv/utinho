//
//  OnboardingOne.swift
//  Uti
//
//  Created by michellyes on 30/08/23.
//

import SwiftUI

struct OnboardingOne: View {
    
    @State private var isButtonClicked = false
    @State private var buttonTextIndex = 0 // Índice para controlar o texto atual
    let onboardingTexts = [
        "Primeiro texto aqui",
        "Segundo texto aqui",
        "Terceiro texto aqui"
    ] // Lista de diferentes textos de onboarding
    
    var currentOnboardingText: String {
        if buttonTextIndex >= onboardingTexts.count {
            return "Texto após o botão ser clicado."
        } else {
            return onboardingTexts[buttonTextIndex]
        }
    }
    
    
    var body: some View {
        ZStack{
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        ZStack {
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
                            }
                            .padding(.horizontal, 4.0)
                            .frame(minWidth: 330, idealWidth: 330, maxWidth: 330, minHeight: 80, idealHeight: 80, maxHeight: 100, alignment: .center)
                            .background(.white)
                            .cornerRadius(20.0)
                        
                        OnboardingButton(onButtonTap: { buttonTextIndex += 1 } )
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
                
                Button("Kit de Sobrevivência Uterina") {
                    
                }
                .frame(maxHeight: 100)
                .multilineTextAlignment(.center)
                .buttonStyle(CustomButtonStyle())
                .fontWeight(.medium)
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
}
//
//struct OnboardingOne_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingOne()
//    }
//}
