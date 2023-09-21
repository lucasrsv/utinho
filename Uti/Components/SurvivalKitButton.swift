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
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(currentCategory == category ? .clear : .darkRed, lineWidth: 2)
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
            return Text("leisure_button_title")
        case .health:
            return Text("health_button_title")
        case .nutrition:
            return Text("nutrition_button_title")
        }
    }
    
}

struct SurvivalKitButton_Previews: PreviewProvider {
    @State static var currentCategory = Category.health
    
    static var previews: some View {
        SurvivalKitButton(category: .leisure, currentCategory: $currentCategory)
    }
}

