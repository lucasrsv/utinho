//
//  CycleChangePopupView.swift
//  Uti
//
//  Created by michellyes on 14/08/23.
//
import SwiftUI

struct CycleChangePopupView: View {
    @Binding var isPopupVisible: Bool
    @State var topInset: CGFloat = 0
    @State var popupWidth: CGFloat = 0
    @State var padding: CGFloat = 0
    @State var cornerRadius: CGFloat = 0
    @State private var showMoreInfo = false
    let uti: Uti
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                HStack(alignment: .center) {
                    VStack(spacing: Responsive.scale(s: Spacing.medium)) {
                        VStack {
                            Text("Utinho está passando pela")
                                .foregroundColor(.darkRed)
                                .font(.system(size: Responsive.scale(s: FontSize.h3.rawValue)))
                            Text(Uti.phaseText(phase: uti.phase))
                                .foregroundColor(.darkRed)
                                .font(.system(size: Responsive.scale(s: FontSize.h3.rawValue)))
                                .fontWeight(FontWeight.bold.value)
                        }
                        .padding(.top, (popupWidth*0.4)/4)
                        
                        if showMoreInfo {
                            ScrollView{
                                VStack(spacing: Responsive.scale(s: Spacing.medium)) {
                                    Text(Uti.getPhase(phase: uti.phase).previewDescription)
                                        .foregroundColor(Color.black.opacity(0.6))
                                        .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                        .multilineTextAlignment(.center)
                                    Text(Uti.getPhase(phase: uti.phase).completeDescription)
                                        .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                        .foregroundColor(Color.black.opacity(0.6))
                                        .multilineTextAlignment(.center)
                                    VStack(alignment: .leading) {
                                        Text("REFERÊNCIAS")
                                            .foregroundColor(Color.black.opacity(0.6))
                                            .fontWeight(FontWeight.semibold.value)
                                            .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                            .padding(.vertical, 8)
                                        Text("Entenda as fases do ciclo menstrual | Drauzio Varella")
                                            .foregroundColor(Color.black.opacity(0.6))
                                            .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                        Link("Acesse aqui", destination: URL(string: "https://drauziovarella.uol.com.br/mulher/menstruacao/entenda-as-fases-do-ciclo-menstrual/")!)
                                            .foregroundColor(Color.blue)
                                            .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                            .padding(.bottom, 8)
                                        Text("Hormônios FSH e LH")
                                            .foregroundColor(Color.black.opacity(0.6))
                                            .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                        Link("Acesse aqui", destination: URL(string: "https://www.gineco.com.br/saude-feminina/menstruacao/hormonio-fsh")!)
                                            .foregroundColor(Color.blue)
                                            .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                            .padding(.bottom, 8)
                                        Text("Period irregularities to get checked out")
                                            .foregroundColor(Color.black.opacity(0.6))
                                            .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                        Link("Acesse aqui", destination: URL(string: "https://www.mayoclinic.org/healthy-lifestyle/womens-health/in-depth/menstrual-cycle/art-20047186")!)
                                            .foregroundColor(Color.blue)
                                            .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                            .padding(.bottom, 8)
                                    }
                                }
                            }
                        } else {
                            Text(Uti.getPhase(phase: uti.phase).previewDescription)
                                .foregroundColor(Color.black.opacity(0.6))
                                .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            PopUpButton(buttonTitle: "Ok, entendi",
                                        buttonSize: geo.size.width > 428 ? ButtonSize.large : ButtonSize.small,
                                        onButtonTap: {
                                isPopupVisible = false
                            }
                            )
                            if !showMoreInfo {
                                Button("saiba mais") {
                                    showMoreInfo.toggle()
                                }
                                .foregroundColor(.darkRed)
                                .fontWeight(FontWeight.semibold.value)
                                .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                .padding(.top, 4)
                            }
                        }
                    }
                    .padding(.all, padding)
                    .background(.white)
                    .cornerRadius(cornerRadius)
                    .overlay {
                        GeometryReader { popupGeometry in
                            ZStack {
                                Circle()
                                    .frame(width: popupWidth*0.4, height: popupWidth*0.4)
                                    .foregroundColor(.white)
                                Image(Uti.getPhase(phase: uti.phase).iconPath)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: popupWidth * 0.4 * 0.6, height: popupWidth * 0.4 * 0.6)
                            }
                            .position(CGPoint(x: popupGeometry.safeAreaInsets.leading + popupGeometry.size.width/2, y: popupGeometry.safeAreaInsets.top))
                        }
                    }
                    .onAppear {
                        topInset = geo.safeAreaInsets.top
                        if (geo.size.width > 428) {
                            popupWidth = geo.size.width * 0.5
                            padding = 48
                            cornerRadius = 36
                        } else {
                            popupWidth = geo.size.width * 0.8
                            padding = 24
                            cornerRadius = 20
                        }
                    }
                }
                .frame(width: Responsive.scale(s: 300))
                .frame(maxHeight: geo.size.height * 0.5)
            }
        }
    }
}

struct CycleChangePopupView_Previews: PreviewProvider {
    static var previews: some View {
        CycleChangePopupView(isPopupVisible: .constant(false), uti: Uti(currentCycleDay: 2, phase: .luteal, state: .sleepy, illness: .no, leisure: 50, health: 50, nutrition: 70, energy: 100, blood: 100, items: []))
    }
}

