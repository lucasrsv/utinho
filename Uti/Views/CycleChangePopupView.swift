//
//  CycleChangePopupView.swift
//  Uti
//
//  Created by michellyes on 14/08/23.
//

import SwiftUI

struct CycleChangePopupView: View {
    @Binding var isPopupVisible: Bool
    var body: some View {
        
        ZStack {
            ZStack {
                Circle()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
            }
            .frame(width: 300, height: 360, alignment: .top)
            
            ZStack{
                ZStack{
                }
                .frame(width: 300, height: 320)
                .background(.white)
                .cornerRadius(24)
            }
            .frame(width: 300, height: 360, alignment: .bottom)

            ZStack{
                VStack(spacing: 20) {
                    Image("blood")
                        .padding(.top, 10)
                    
                    VStack(spacing: 16) {
                        VStack{
                            Text("Utinho está passando pela")
                                .foregroundColor(.darkRed)
                            Text("FASE MENSTRUAL")
                                .foregroundColor(.darkRed)
                                .fontWeight(.bold)
                        }
                        
                        Text("Nesse momento o Utinho começa a ter seu tecido descamado (relaxe, não dói muito). Algumas cólicas podem surgir. Tenha cuidado com ele.")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .padding(.leading, 16)
                            .padding(.trailing, 16)
                        
                        VStack{
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
                        .padding(.bottom, 16)
                    }
                }
            }
            .frame(width: 300, height: 360, alignment: .bottom)
        }
        .frame(width: 300, height: 360)
    }
    
//    struct CycleChangePopupView_Previews: PreviewProvider {
//        static var previews: some View {
//            CycleChangePopupView()
//        }
//    }
}
