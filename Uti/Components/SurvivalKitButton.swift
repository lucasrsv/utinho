//
//  SurvivalKitButton.swift
//  Uti
//
//  Created by michellyes on 31/07/23.
//

import SwiftUI
struct SurvivalKitButton: View {
    
    let category: Category
    @Binding var currentCategory: Category
    
    var body: some View {
        HStack{
            Button(action: {
                currentCategory = category
                print("Button touched")
            }, label: {
                ZStack {
                    // button border
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(currentCategory == category ? .clear : .darkRed, lineWidth: 2)
                    // button background
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(currentCategory == category ? .darkRed : .white)
                    
                    HStack {
                        getIcon()
                            .font(.system(size: 16))
                            .foregroundColor(currentCategory == category ? .white : .darkRed)
                        getTitle()
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(currentCategory == category ? .white : .darkRed)
                    }
                }
                .frame(width: 100, height: 36)
            })
        }
    }
    
    func getIcon() -> Image {
        switch category {
        case .leisure:
            return Image(systemName: "party.popper.fill")
        case .health:
            return Image(systemName: "cross.fill")
        case .nutrition:
            return Image(systemName: "fork.knife")
        }
    }
    
    func getTitle() -> Text {
        switch category {
        case .leisure:
            return Text("Lazer")
        case .health:
            return Text("Saúde")
        case .nutrition:
            return Text("Nutrição")
        }
    }
    
}

