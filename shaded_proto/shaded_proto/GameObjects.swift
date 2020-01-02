//
//  GameObjects.swift
//  shaded_proto
//
//  Created by Luqman Abdurrohman on 1/1/20.
//  Copyright © 2020 Luqman Abdurrohman. All rights reserved.
//

import SpriteKit
import GameplayKit


extension GameScene {
    
    
    @objc func normalShape(){
        
        
        
    }
    
    @objc func targetShape(){
        
        let rgbPackage = createRGB_Values()
        let rgbTarget = rgbPackage[1]
        let colorTarget: SKColor = SKColor.init(red: rgbTarget[0], green: rgbTarget[1], blue: rgbTarget[2], alpha: 1)
        
        // Dimensions and Positioning of TargetedShape
        let shape = SKShapeNode(circleOfRadius: 85)
        shape.position = CGPoint(x: ((frame.maxX)/1.50), y: frame.maxY)
        shape.strokeColor = colorTarget
        //shape.fillColor = colorTarget
        shape.glowWidth = 1.0
        shape.lineWidth = 15
        
        // Physics Attribute
        shape.physicsBody = SKPhysicsBody(circleOfRadius: 85)
        shape.physicsBody?.isDynamic = true
        shape.physicsBody?.allowsRotation = false
        shape.physicsBody?.pinned = false
        shape.physicsBody?.affectedByGravity = true
        shape.physicsBody?.friction = 0.0
        shape.physicsBody?.restitution = 0.4     //BOUNCYINESS
        shape.physicsBody?.linearDamping = 0.3
        shape.physicsBody?.angularDamping = 0.2
        
        // Collision Attributes
        shape.physicsBody?.categoryBitMask = shapeCategory
        shape.physicsBody?.contactTestBitMask = platformCategory
        shape.physicsBody?.collisionBitMask = platformCategory
        shape.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(shape)
    }
    
    func addPlatform(){
        
        // Dimensions, Positioning, and Color of Platform
        platform = SKShapeNode.init(rectOf: CGSize.init(width: 200, height: 30))
        platform.position = CGPoint(x: 0,  y: -570)
        platform.fillColor = SKColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        platform.strokeColor = SKColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        
        // Physics Attributes
        platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 30))
        platform.physicsBody?.isDynamic = false
        platform.physicsBody?.allowsRotation = false
        platform.physicsBody?.pinned = false
        platform.physicsBody?.affectedByGravity = false
        platform.physicsBody?.friction = 0.0
        platform.physicsBody?.restitution = 0.0 //BOUNCYINESS
        platform.physicsBody?.linearDamping = 0.1
        platform.physicsBody?.angularDamping = 0.1
        
        // Collision Attributes
        platform.physicsBody?.categoryBitMask = platformCategory
        platform.physicsBody?.contactTestBitMask = shapeCategory
        platform.physicsBody?.collisionBitMask = platformCategory | shapeCategory
        
        self.addChild(platform)
        
    }
    
    
    
    func addLabel(){
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.position = CGPoint(x: 0, y: 0)
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 200
        
        self.addChild(scoreLabel)
    }
    
 
}
