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
    var boxes: [SKSpriteNode] = []
    var points: Int = 0
    var gameOver: Bool = false
    let utiCategoryBitMask: UInt32 = 0x1 << 0
    let boxCategoryBitMask: UInt32 = 0x1 << 1
    let groundCategoryBitMask: UInt32 = 0x1 << 2
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        applyContinuousForceToBoxes()
    }
    
    override func didMove(to view: SKView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        
        let borders = SKSpriteNode()
        borders.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        addChild(borders)
        
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
        ground.physicsBody?.categoryBitMask = groundCategoryBitMask
        ground.physicsBody?.collisionBitMask = utiCategoryBitMask
        ground.position = CGPoint(x: size.width / 2, y: ground.frame.height / 2)
        ground.fillColor = SKColor(.paleRed)
        ground.lineWidth = 0
        
        uti = SKSpriteNode(imageNamed: "happy")
        uti.size = CGSize(width: uti.size.width/5, height: uti.size.height/5)
        uti.position = CGPoint(x: size.width/2, y: size.height*0.8)
        uti.physicsBody = SKPhysicsBody(rectangleOf: uti.size)
        uti.physicsBody?.isDynamic = true
        uti.physicsBody?.restitution = 0.3
        uti.physicsBody?.usesPreciseCollisionDetection = true
        uti.physicsBody?.categoryBitMask = utiCategoryBitMask
        uti.physicsBody?.contactTestBitMask = boxCategoryBitMask
        uti.physicsBody?.collisionBitMask = groundCategoryBitMask
        
        let background = SKSpriteNode(imageNamed: "blood_background.png")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        scene?.addChild(ground)
        scene?.addChild(uti)
        
        let createBoxAction = SKAction.run { [weak self] in
            self?.createRandomBox()
        }
        let waitAction = SKAction.wait(forDuration: 1.5) // Adjust the duration as needed
        let createAndWaitSequence = SKAction.sequence([createBoxAction, waitAction])
        let repeatForeverAction = SKAction.repeatForever(createAndWaitSequence)
        run(repeatForeverAction)
        
        
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
    
    func createRandomBox() {
        // Load the blood image
        let bloodImage = SKSpriteNode(imageNamed: "platform.png")

        // Set the size of the blood image
        bloodImage.size = CGSize(width: 80, height: 24)

        // Generate a random X position for the blood image
        let randomX = CGFloat.random(in: 0..<size.width)

        // Position the blood image at the calculated random X position and at the top of the screen
        bloodImage.position = CGPoint(x: randomX, y: size.height)

        // Add a physics body to the blood image
        bloodImage.physicsBody = SKPhysicsBody(rectangleOf: bloodImage.size)
        bloodImage.physicsBody?.isDynamic = true
        bloodImage.physicsBody?.affectedByGravity = false
        bloodImage.physicsBody?.categoryBitMask = boxCategoryBitMask
        bloodImage.physicsBody?.collisionBitMask = 0

        // Add the blood image as a child of the scene
        addChild(bloodImage)
        boxes.append(bloodImage)    }
    
    func applyContinuousForceToBoxes() {
        for box in boxes {
            let force = CGVector(dx: 0, dy: -6.0)
            box.physicsBody?.applyForce(force)
        }
    }

    func startApplyingForceToBoxes() {
        let applyForceAction = SKAction.run { [weak self] in
            self?.applyContinuousForceToBoxes()
        }
        let waitAction = SKAction.wait(forDuration: 0.1)
        let applyForceSequence = SKAction.sequence([applyForceAction, waitAction])
        let repeatForeverAction = SKAction.repeatForever(applyForceSequence)
        run(repeatForeverAction)
    }
    
    func jumpUti() {
        let jumpImpulse = CGVector(dx: 0, dy: 600.0)
        uti.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        uti.physicsBody?.applyImpulse(jumpImpulse)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == (utiCategoryBitMask | boxCategoryBitMask) {
            jumpUti()
            points = points + 1
        } else if contactMask == (utiCategoryBitMask | groundCategoryBitMask)  {
            print("aa")
        }
    }
    
}
