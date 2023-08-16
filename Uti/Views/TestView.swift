//
//  TestView.swift
//  Uti
//
//  Created by michellyes on 16/08/23.
//

import SwiftUI

struct TestView: View {
    @State var topInset: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .center) {
            GeometryReader { geo in
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
                            // isPopupVisible = false
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
                            .frame(width: 120, height: 120)
                            .foregroundColor(.white)
                        Image("blood")
                    }
                    .position(CGPoint(x: UIScreen.main.bounds.midX, y: topInset - 40))
                    
                }
                
                .onAppear {
                    topInset = geo.safeAreaInsets.top
                }
            }
        }
        .frame(height: .infinity)
    }
}
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}
