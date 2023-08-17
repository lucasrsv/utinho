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
    @State var bodyText: CGFloat = 0
    @State var titleText: CGFloat = 0
    @State var padding: CGFloat = 0
    @State var cornerRadius: CGFloat = 0
    @State var distanceNeeded: CGFloat = 0
   // var buttonSize: ButtonSize
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                HStack(alignment: .center) {
                    VStack(spacing: 16) {
                        VStack {
//                            Rectangle()
//                                .frame(width: popupWidth*0.4, height: (popupWidth*0.4)*0.35)
//                                .background(.blue)
                            Text("Utinho está passando pela")
                                .foregroundColor(.darkRed)
                                .font(.system(size: Responsive.scale(s: FontSize.h3.rawValue)))
                            Text("FASE MENSTRUAL")
                                .foregroundColor(.darkRed)
                                .font(.system(size: Responsive.scale(s: FontSize.h3.rawValue)))
                                .fontWeight(FontWeight.bold.value)
                        }
                        //.padding(.top)
                        Text("Nesse momento o Utinho começa a ter seu tecido descamado (relaxe, não dói muito). Algumas cólicas podem surgir. Tenha cuidado com ele.")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .font(.system(size: Responsive.scale(s: FontSize.body.rawValue)))
                        
                            .multilineTextAlignment(.center)
                        VStack {
                           // PopUpButton(buttonSize: )
                            Button("Ok, tendi!") {
                                isPopupVisible = false
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.darkRed)
                            .cornerRadius(12)
                            Text("saiba mais")
                                .foregroundColor(.darkRed)
                                .scaledToFill()
                        }
                    }
                    .padding(.all, padding)
                    .background(.white)
                    .cornerRadius(cornerRadius)
                    
                    .overlay {
                        ZStack {
                            Circle()
                                .frame(width: popupWidth*0.4, height: popupWidth*0.4)
                                .foregroundColor(.white)
                            Image("blood")
                                .scaledToFill()
                        }
                        .position(CGPoint(x: geo.size.width * distanceNeeded / 2, y: topInset - 40))
                        
                    }
                    
                    .onAppear {
                        topInset = geo.safeAreaInsets.top
                        if (geo.size.width > 428) {
                            popupWidth = geo.size.width * 0.5
                            bodyText = 28
                            titleText = 36
                            padding = 48
                            cornerRadius = 36
                            distanceNeeded = 0.50
                        } else {
                            popupWidth = geo.size.width * 0.8
                            bodyText = 16
                            titleText = 18
                            padding = 24
                            cornerRadius = 20
                            distanceNeeded = 0.80
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
