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
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                HStack(alignment: .center) {
                    VStack(spacing: 16) {
                        VStack {
                            Text("Utinho está passando pela")
                                .foregroundColor(.darkRed)
                            Text("FASE MENSTRUAL")
                                .foregroundColor(.darkRed)
                                .fontWeight(.bold)
                        }
                        .padding(.top, 40)
                        Text("Nesse momento o Utinho começa a ter seu tecido descamado (relaxe, não dói muito). Algumas cólicas podem surgir. Tenha cuidado com ele.")
                            .foregroundColor(Color.gray.opacity(0.5))
                        VStack {
                            Button("Ok, tendi!") {
                                isPopupVisible = false
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.darkRed)
                            .cornerRadius(12)
                            Text("saiba mais")
                                .foregroundColor(.darkRed)
                        }
                    }
                    .padding(.all, 20)
                    .background(.white)
                    .cornerRadius(24)
                    
                    .overlay {
                        
                        ZStack {
                            Circle()
                                .frame(minWidth: 120, idealWidth:geo.size.width * 0.40, maxWidth: 240, minHeight: 120, idealHeight: geo.size.width * 0.40, maxHeight: 240)
                                .foregroundColor(.white)
                            Image("blood")
                        }
                        .position(CGPoint(x: geo.size.width * 0.80 / 2, y: topInset - 40))
                        
                    }
                    
                    .onAppear {
                        topInset = geo.safeAreaInsets.top
                    }
                }
                .frame(width: geo.size.width * 0.80, height: geo.size.height * 0.60)
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
