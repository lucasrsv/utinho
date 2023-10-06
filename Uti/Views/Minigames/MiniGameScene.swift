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
    var cameraNode = SKCameraNode()
    var cameraMovePointPerSecond: CGFloat = 450.0
    var leftBarrier: SKSpriteNode!
    var rightBarrier: SKSpriteNode!
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        applyContinuousForceToBoxes()
       // moveBG()
        
        camera?.position.y = uti.position.y
        
        // Ajustar a posição das barreiras laterais para acompanhar a câmera
        leftBarrier.position.y = cameraNode.position.y
        rightBarrier.position.y = cameraNode.position.y
    }
    
    override func didMove(to view: SKView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        
        let borders = SKSpriteNode()
        borders.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        addChild(borders)
        
        
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
    
        setupNodes()
        setupGround()
        scene?.addChild(uti)
        
        let createBoxAction = SKAction.run { [weak self] in
            self?.createRandomBox()
        }
        let waitAction = SKAction.wait(forDuration: 1) // Adjust the duration as needed
        let createAndWaitSequence = SKAction.sequence([createBoxAction, waitAction])
        let repeatForeverAction = SKAction.repeatForever(createAndWaitSequence)
        run(repeatForeverAction)
        
        leftBarrier = SKSpriteNode(color: .white, size: CGSize(width: 20, height: size.height))
        leftBarrier.position = CGPoint(x: 0, y: 0)
        leftBarrier.physicsBody = SKPhysicsBody(rectangleOf: leftBarrier.size)
        leftBarrier.physicsBody?.isDynamic = false
        leftBarrier.physicsBody?.categoryBitMask = groundCategoryBitMask
        addChild(leftBarrier)
        
        // Barreira lateral direita
        rightBarrier = SKSpriteNode(color: .white, size: CGSize(width: 20, height: size.height))
        rightBarrier.position = CGPoint(x: size.width, y: 0)
        rightBarrier.physicsBody = SKPhysicsBody(rectangleOf: rightBarrier.size)
        rightBarrier.physicsBody?.isDynamic = false
        rightBarrier.physicsBody?.categoryBitMask = groundCategoryBitMask
        addChild(rightBarrier)
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
    
    func setupNodes() {
        createBG()
        setupCamera()
    }
    
    func createBG() {
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: "blood_background.png")
            bg.zPosition = -1.0
            bg.name = "BG"
            bg.position = CGPoint(x: frame.width/2.0, y: CGFloat(i)*bg.frame.height + frame.height/2.0)
            addChild(bg)
        }
    }
    
    func setupGround() {
        let groundPath = CGMutablePath()
        groundPath.move(to: CGPoint(x: -size.width/2, y: -size.height*0.005))
        groundPath.addLine(to: CGPoint(x: size.width/2, y: -size.height*0.005))
        groundPath.addLine(to: CGPoint(x: size.width/2, y: size.height*0.005))
        groundPath.addLine(to: CGPoint(x: -size.width/2, y: size.height*0.005))
        groundPath.closeSubpath()
        
        let ground = SKShapeNode(path: groundPath)
        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
        ground.physicsBody?.isDynamic = true
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.categoryBitMask = groundCategoryBitMask
        ground.physicsBody?.collisionBitMask = utiCategoryBitMask
        ground.position = CGPoint(x: size.width / 2, y: ground.frame.height / 2)
        ground.fillColor = SKColor(.yellow)
        ground.lineWidth = 0
        
        scene?.addChild(ground)
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
            let force = CGVector(dx: 0, dy: -14.0)
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
        let jumpImpulse = CGVector(dx: 0, dy: 400.0)
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
    
    func setupCamera() {
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
    }
    
}
