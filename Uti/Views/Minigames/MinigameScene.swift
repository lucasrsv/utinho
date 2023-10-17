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
    var minCameraYPosition: CGFloat = 0.0
    var didJump = false
    var scoreLabel: SKLabelNode!
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        createBG()
        applyContinuousForceToBoxes()
        // moveBG()
        minCameraYPosition = size.height / 2
        scoreLabel.position = CGPoint(x: cameraNode.position.x, y:cameraNode.position.y - 500)
        if (uti.position.y < minCameraYPosition) {
            camera?.position.y = minCameraYPosition
        } else {
            camera?.position.y = uti.position.y
        }
        leftBarrier.position.y = cameraNode.position.y
        rightBarrier.position.y = cameraNode.position.y
        
        boxes = boxes.filter { box in
            let cameraBottomY = cameraNode.position.y - size.height / 2
            if box.position.y < cameraBottomY {
                box.removeFromParent()
                return false
            }
            return true
        }
        
    }
    
    override func didMove(to view: SKView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        
        uti = SKSpriteNode(imageNamed: "happy")
        uti.size = CGSize(width: uti.size.width/5, height: uti.size.height/5)
        uti.position = CGPoint(x: size.width/2, y: size.height/2)
        uti.zPosition = 1
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
        let waitAction = SKAction.wait(forDuration: 0.5) // Adjust the duration as needed
        let createAndWaitSequence = SKAction.sequence([createBoxAction, waitAction])
        let repeatForeverAction = SKAction.repeatForever(createAndWaitSequence)
        run(repeatForeverAction)
        
        leftBarrier = SKSpriteNode(color: .white, size: CGSize(width: 200, height: size.height))
        leftBarrier.position = CGPoint(x: -100, y: 0)
        leftBarrier.physicsBody = SKPhysicsBody(rectangleOf: leftBarrier.size)
        leftBarrier.physicsBody?.isDynamic = false
        leftBarrier.physicsBody?.categoryBitMask = groundCategoryBitMask
        addChild(leftBarrier)
        
        // Barreira lateral direita
        rightBarrier = SKSpriteNode(color: .white, size: CGSize(width: 200, height: size.height))
        rightBarrier.position = CGPoint(x: size.width+100, y: 0)
        rightBarrier.physicsBody = SKPhysicsBody(rectangleOf: rightBarrier.size)
        rightBarrier.physicsBody?.isDynamic = false
        rightBarrier.physicsBody?.categoryBitMask = groundCategoryBitMask
        addChild(rightBarrier)
        
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 24
        scoreLabel.position = CGPoint(x: cameraNode.position.x, y: size.height / 2 - cameraNode.position.y)
        scoreLabel.horizontalAlignmentMode = .right
//        addChild(scoreLabel)
        
        
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
        setupCamera()
    }
    
    func createBG() {
        let bgTexture = SKTexture(imageNamed: "blood_background.png")
        let cameraTopY = cameraNode.position.y
        
        // Calculate the number of background nodes needed to cover the scene height
        let numberOfBGNodes = Int(ceil(size.height / bgTexture.size().height))
        
        // Ensure there are enough background nodes to cover the scene
        while children.filter({ $0.name == "BG" }).count < numberOfBGNodes {
            let bg = SKSpriteNode(texture: bgTexture)
            bg.zPosition = -1.0
            bg.name = "BG"
            bg.size = bgTexture.size()
            addChild(bg)
        }
        
        // Remove any background nodes that are above the camera's top position
        children.filter({ $0.name == "BG" }).forEach { bgNode in
            if bgNode.position.y > cameraTopY + bgTexture.size().height / 2 {
                bgNode.removeFromParent()
            }
        }
        
        // Position the remaining background nodes
        let existingBGNodes = children.filter({ $0.name == "BG" })
        for (index, bgNode) in existingBGNodes.enumerated() {
            bgNode.position = CGPoint(x: frame.midX, y: cameraTopY - CGFloat(index) * bgTexture.size().height)
        }
    }
    func setupGround() {
        let ground = SKSpriteNode(color: UIColor(Color.darkRed), size: CGSize(width: size.width, height: size.height*0.05))
        ground.position = CGPoint(x: size.width / 2, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.categoryBitMask = groundCategoryBitMask
        ground.physicsBody?.collisionBitMask = utiCategoryBitMask
        ground.physicsBody?.contactTestBitMask = utiCategoryBitMask
        
        scene?.addChild(ground)
    }
    
    func createRandomBox() {
        // Load the blood image
        let bloodImage = SKSpriteNode(imageNamed: "platform.png")
        
        // Set the size of the blood image
        bloodImage.size = CGSize(width: 80, height: 24)
        
        // Generate a random X position for the blood image
        let randomX = CGFloat.random(in: 0..<size.width)
        let cameraTopY = cameraNode.position.y + size.height / 2
        let minDistance = 200.0 // Adjust this value as needed
        let minY = max(uti.position.y + minDistance, cameraTopY)
        
        bloodImage.position = CGPoint(x: randomX, y: minY)
        
        
        // Add a physics body to the blood image
        bloodImage.physicsBody = SKPhysicsBody(rectangleOf: bloodImage.size)
        bloodImage.physicsBody?.isDynamic = true
        bloodImage.physicsBody?.affectedByGravity = false
        bloodImage.physicsBody?.categoryBitMask = boxCategoryBitMask
        bloodImage.physicsBody?.collisionBitMask = 0
        let velocity = CGVector(dx: 0, dy: -100.0) // Adjust the dy value as needed
        bloodImage.physicsBody?.velocity = velocity
        // Add the blood image as a child of the scene
        addChild(bloodImage)
        boxes.append(bloodImage)
    }
    
    func applyContinuousForceToBoxes() {
        for box in boxes {
            let force = CGVector(dx: 0, dy: -14.0)
            box.physicsBody?.applyForce(force)
        }
    }
    
    func jumpUti() {
        let jumpImpulse = CGVector(dx: 0, dy: 400.0)
        uti.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        uti.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
        uti.physicsBody?.applyImpulse(jumpImpulse)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == (utiCategoryBitMask | boxCategoryBitMask) {
            jumpUti()
            points = points + 1
            if !didJump {
                didJump = true
            }
        } else if contactMask == (utiCategoryBitMask | groundCategoryBitMask)  {
            if didJump {
                pauseGame()
                showGameOverPopup()
            }
        }
    }
    
    func setupCamera() {
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
    }
    
    func showGameOverPopup() {
        let alertController = UIAlertController(title: "Game Over", message: "Você conseguiu \(points) gotas de sangue!", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Reiniciar", style: .default) { [weak self] _ in
            self?.resetGame()
        }
        let leaveAction = UIAlertAction(title: "Sair", style: .default) { [weak self] _ in
            self?.leaveGame()
        }
        alertController.addAction(restartAction)
        alertController.addAction(leaveAction)
        
        // Present the game over popup
        if let viewController = view?.window?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func resetGame() {
        // Reset any game state variables, remove remaining boxes, reset uti's position, etc.
        for box in boxes {
            box.removeFromParent()
        }
        boxes.removeAll()
        
        // Reset uti's position
        uti.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        // Reset points and any other game-related data
        points = 0
            updateScoreLabel()
        // Close the game over popup if it's currently displayed
        if let viewController = view?.window?.rootViewController {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func pauseGame() {
        view?.isPaused = true
    }
    
    func leaveGame() {
        if let viewController = view?.window?.rootViewController {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(points)"
    }
}

protocol MiniGameSceneDelegate: AnyObject {
    func leaveMiniGame(isPresented: Binding<Bool>)
}
