//
//  FoodRainGameScene.swift
//  Uti
//
//  Created by jpbol on 16/08/2023.
//

import Foundation
import SwiftUI
import SpriteKit

class FoodRainGameScene: SKScene, SKPhysicsContactDelegate {
    var uti: SKShapeNode?
    
    
    override func sceneDidLoad (){
        super.sceneDidLoad()
        backgroundColor = .green
    }
    
    override func didMove(to view: SKView) {
      startGame()
    }

    func startGame() {
      self.removeAllChildren()
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
