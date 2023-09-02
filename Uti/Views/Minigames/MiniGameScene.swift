//
//  MiniGameScene.swift
//  Uti
//
//  Created by lrsv on 02/09/23.
//

import SwiftUI
import SpriteKit
import UIKit
import Foundation

class MiniGameScene: SKScene, SKPhysicsContactDelegate {
    var uti: SKSpriteNode!
    var initialPosition: CGPoint = CGPoint()
    
    override func didMove(to view: SKView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        let groundPath = CGMutablePath()
        groundPath.move(to: CGPoint(x: -size.width/2, y: -size.height*0.05))
        groundPath.addLine(to: CGPoint(x: size.width/2, y: -size.height*0.05))
        groundPath.addLine(to: CGPoint(x: size.width/2, y: size.height*0.05))
        groundPath.addLine(to: CGPoint(x: -size.width/2, y: size.height*0.05))
        groundPath.closeSubpath()
        
        let ground = SKShapeNode(path: groundPath)
        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        ground.position = CGPoint(x: size.width / 2, y: ground.frame.height / 2)
        ground.fillColor = SKColor(.pink)
        ground.lineWidth = 0
        
        uti = SKSpriteNode(imageNamed: "happy")
        uti.size = CGSize(width: uti.size.width/4, height: uti.size.height/4)
        uti.position = CGPoint(x: size.width/2, y: size.height*0.8)
        uti.physicsBody = SKPhysicsBody(rectangleOf: uti.size)
        uti.physicsBody?.isDynamic = true
        uti.physicsBody?.restitution = 0.3
        uti.physicsBody?.usesPreciseCollisionDetection = true
        
        scene?.addChild(ground)
        scene?.addChild(uti)
        
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            initialPosition = uti.position
        case .changed:
            let translation = gesture.translation(in: view)
            uti.position = CGPoint(x: initialPosition.x + translation.x, y: uti.position.y)
        default:
            break
            
        }
    }
    
    func moveUti() {
        
    }
    
    func stopUti() {
        
    }
    
}
