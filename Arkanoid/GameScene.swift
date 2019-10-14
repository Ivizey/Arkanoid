//
//  GameScene.swift
//  Arkanoid
//
//  Created by mac on 14.10.19.
//  Copyright © 2019 ivizey. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsBodyes {
    static let BallPhBodyMask: UInt32 = 1
    static let BrickPhBodMask: UInt32 = 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: SKSpriteNode?
    var paddle: SKSpriteNode?
   
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "Ball") as? SKSpriteNode
        paddle = self.childNode(withName: "Paddle") as? SKSpriteNode
        
        self.physicsWorld.contactDelegate = self
        ball?.physicsBody?.applyImpulse(CGVector(dx: 150, dy: 150))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle?.position = touchLocation
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle?.position.x = touchLocation.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var bodyA = contact.bodyA.node
        var bodyB = contact.bodyB.node
        if bodyA?.physicsBody?.categoryBitMask == PhysicsBodyes.BallPhBodyMask && bodyB?.physicsBody?.categoryBitMask == PhysicsBodyes.BrickPhBodMask {
            bodyB?.removeFromParent()
        }
        if bodyA?.physicsBody?.categoryBitMask == PhysicsBodyes.BrickPhBodMask && bodyB?.physicsBody?.categoryBitMask == PhysicsBodyes.BallPhBodyMask {
            bodyA?.removeFromParent()
        }
    }
}
