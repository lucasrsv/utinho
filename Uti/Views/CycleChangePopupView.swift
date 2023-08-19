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
                    VStack(spacing: 16) {
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
                        Text(Uti.getPhase(phase: uti.phase).previewDescription)
                            .foregroundColor(Color.gray.opacity(0.8))
                            .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                            .multilineTextAlignment(.center)
                        
                        if showMoreInfo {
                            Text(Uti.getPhase(phase: uti.phase).completeDescription)
                                .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                                .foregroundColor(.darkRed)
                                .multilineTextAlignment(.center)
                        }
                        VStack {
                            PopUpButton(buttonTitle: "Ok, entendi",
                                        buttonSize: geo.size.width > 428 ? ButtonSize.large : ButtonSize.small,
                                        action: {
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
            }
        }
    }
    
}

//    struct CycleChangePopupView_Previews: PreviewProvider {
//        static var previews: some View {
//            CycleChangePopupView()
//        }
//    }
//}
