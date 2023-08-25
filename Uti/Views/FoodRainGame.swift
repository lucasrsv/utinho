//
//  FoodRainGame.swift
//  Uti
//
//  Created by jpbol on 16/08/2023.
//

import Foundation
import SwiftUI
import SpriteKit

struct FoodRainGame: View {
    var foodRainGameScene: SKScene {
        let scene = FoodRainGameScene()
        return scene
    }
    
    var body: some View {
        SpriteView(scene: foodRainGameScene)
            .ignoresSafeArea()
    }
}
