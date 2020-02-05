//
//  GameScene.swift
//  shaded_proto
//
//  Created by Luqman Abdurrohman on 1/1/20.
//  Copyright © 2020 Luqman Abdurrohman. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {

    let circle = (SKShapeNode(circleOfRadius: 85), SKPhysicsBody(circleOfRadius: 85))


    var platform = SKShapeNode()
    var boundary = SKShapeNode()
    var heartLives = SKSpriteNode()
    
    let middle = SKSpriteNode()
    let right = SKSpriteNode()
    let left = SKSpriteNode()
    var livesArray = [SKSpriteNode()]
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0{
        didSet{
            scoreLabel.text = "\(score)"
        }
    }
    
    var gameTimer:Timer!
    
    let boundaryCategory:UInt32 = 0x1 << 3
    let normalCategory:UInt32 = 0x1 << 2
    let targetCategory:UInt32 = 0x1 << 1
    let platformCategory:UInt32 = 0x1 << 0
    
    
    override func didMove(to view: SKView) {
        
        addBoundary()
        addPlatform()
        addLabel()
        lives(middle: middle, left: left, right: right)
        

        
        let action = SKAction.sequence([SKAction.wait(forDuration: 6.0), SKAction.run {
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.threeShapes), userInfo: nil, repeats: true)
            }])
        
        run(action)

        
        //gameTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(threeShapes), userInfo: nil, repeats: true)
        
        self.physicsWorld.contactDelegate = self
    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for t in touches {
            
            let location = t.location(in: self)
            
            platform.run(SKAction.moveTo(x: location.x, duration: 0.2))

        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            
            let location = t.location(in: self)

            platform.run(SKAction.moveTo(x: location.x, duration: 0.2))

        }
        
    }
    


    

    
    override func update(_ currentTime: TimeInterval) {

    }
}


