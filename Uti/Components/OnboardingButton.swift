//
//  OnboardingButton.swift
//  Uti
//
//  Created by michellyes on 30/08/23.
//

import SwiftUI

struct OnboardingButton: View {
    let onButtonTap: () -> Void
    
    var body: some View {
        Button(action: {
            onButtonTap()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .frame(width: 76.0, height: 40.0)
                    .foregroundColor(.lightBlue)
                Image("next")
            }
        })
    }
}

struct OnboardingButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingButton(onButtonTap: { print("clicou") })
    }
}
