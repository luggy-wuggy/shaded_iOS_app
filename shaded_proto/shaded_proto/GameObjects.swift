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
    
    @objc func threeShapes(){
        
        // RGB picker
        let rgbPackage = createRGB_Values()
        let rgbNormal = rgbPackage[0]
        let rgbTarget = rgbPackage[1]
        let normalColor: SKColor = SKColor.init(red: rgbNormal[0], green: rgbNormal[1], blue: rgbNormal[2], alpha: 1)
        let targetColor: SKColor = SKColor.init(red: rgbTarget[0], green: rgbTarget[1], blue: rgbTarget[2], alpha: 1)
        
        
        var shapePosition : [CGFloat] = [(frame.minX)/1.5, (frame.midX), (frame.maxX)/1.5]
        shapePosition = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: shapePosition) as! [CGFloat]
        let randomPosition = shapePosition.popLast()!
        
        shape(xPosition: randomPosition, rgbValue: targetColor, targetBool: true)
        
        for _ in 0 ... 1{
            let randomPosition = shapePosition.popLast()!
            shape(xPosition: randomPosition, rgbValue: normalColor, targetBool: false)
        }

    }
    
    @objc func shape(xPosition: CGFloat, rgbValue: SKColor, targetBool: Bool){
        
        // Dimensions and Positioning of TargetedShape
        let shape = SKShapeNode(circleOfRadius: 85)
        shape.position = CGPoint(x: xPosition, y: frame.maxY + 120)
        shape.strokeColor = rgbValue
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
        if targetBool{
            shape.physicsBody?.categoryBitMask = targetCategory
            shape.physicsBody?.contactTestBitMask = platformCategory | boundaryCategory
        }else{
            shape.physicsBody?.categoryBitMask = normalCategory
            shape.physicsBody?.contactTestBitMask = platformCategory | boundaryCategory
        }
        shape.physicsBody?.collisionBitMask = platformCategory | boundaryCategory | targetCategory | normalCategory
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
        platform.physicsBody?.contactTestBitMask = targetCategory | normalCategory
        platform.physicsBody?.collisionBitMask = platformCategory | targetCategory | normalCategory
        
        self.addChild(platform)
    }
    
    func addBoundary(){
        
        boundary = SKShapeNode.init(rectOf: CGSize.init(width: 900, height: 30))
        boundary.position = CGPoint(x: frame.midX, y: frame.minY)
        boundary.fillColor = SKColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        boundary.strokeColor = SKColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        
        // Physics Attributes
        boundary.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 900, height: 30))
        boundary.physicsBody?.isDynamic = false
        boundary.physicsBody?.allowsRotation = false
        boundary.physicsBody?.pinned = false
        boundary.physicsBody?.affectedByGravity = false
        boundary.physicsBody?.friction = 0.0
        boundary.physicsBody?.restitution = 0.0 //BOUNCYINESS
        boundary.physicsBody?.linearDamping = 0.1
        boundary.physicsBody?.angularDamping = 0.1
        
        boundary.physicsBody?.categoryBitMask = boundaryCategory
        boundary.physicsBody?.contactTestBitMask = targetCategory | normalCategory
        boundary.physicsBody?.collisionBitMask = boundaryCategory | targetCategory | normalCategory
        
        self.addChild(boundary)
    }
    
    
    
    func addLabel(){
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.position = CGPoint(x: 0, y: 0)
        scoreLabel.zPosition = -1
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 200
        
        self.addChild(scoreLabel)
    }
    
 
}
