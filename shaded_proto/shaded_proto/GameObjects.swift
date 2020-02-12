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
    
    @objc func threeShapes(shapes : Bool){
        
        
        // RGB picker
        let rgbPackage = createRGB_Values()
        let rgbNormal = rgbPackage[0]
        let rgbTarget = rgbPackage[1]
        let normalColor: SKColor = SKColor.init(red: rgbNormal[0], green: rgbNormal[1], blue: rgbNormal[2], alpha: 1)
        let targetColor: SKColor = SKColor.init(red: rgbTarget[0], green: rgbTarget[1], blue: rgbTarget[2], alpha: 1)
        
        var shapePosition : [CGFloat] = [(frame.minX)/1.5, (frame.midX), (frame.maxX)/1.5]
        shapePosition = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: shapePosition) as! [CGFloat]
        let randomPosition = shapePosition.popLast()!
        
        
        if shapes{
            shape(xPosition: randomPosition, rgbValue: targetColor, targetBool: true, shape: true)
            
            for _ in 0 ... 1{
                let randomPosition = shapePosition.popLast()!
                shape(xPosition: randomPosition, rgbValue: normalColor, targetBool: false, shape: true)
            }
        }else{
            let randomShape = Bool.random()
            
            shape(xPosition: randomPosition, rgbValue: targetColor, targetBool: true, shape: randomShape)
            
            for _ in 0 ... 1{
                let randomPosition = shapePosition.popLast()!
                shape(xPosition: randomPosition, rgbValue: normalColor, targetBool: false, shape: randomShape)
            }
        }
        
        

    }
    
    
    
    func addPlatform(){
        
        // Dimensions, Positioning, and Color of Platform
        platform = SKShapeNode.init(rectOf: CGSize.init(width: 170, height: 30))
        platform.position = CGPoint(x: 0,  y: -570)
        platform.fillColor = SKColor.white
        platform.strokeColor = SKColor.white
        
        // Physics Attributes
        platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 170, height: 30))
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
        
        objectFadeIn(object: platform, pauseDuration: 1.4, duration: 3.0)
        
        self.addChild(platform)

        
        
    }
        
    func addBoundary(){
        
        boundary = SKShapeNode.init(rectOf: CGSize.init(width: 900, height: 30))
        boundary.position = CGPoint(x: frame.midX, y: frame.minY - 500)
        boundary.fillColor = SKColor.white
        boundary.strokeColor = SKColor.white
        
        // Physics Attributes
        boundary.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 900, height: 30))
        boundary.physicsBody?.isDynamic = false
        boundary.physicsBody?.allowsRotation = false
        boundary.physicsBody?.pinned = false
        boundary.physicsBody?.affectedByGravity = false
        boundary.physicsBody?.friction = 0.0
        boundary.physicsBody?.restitution = 0.0 //BOUNCYINESS
        boundary.physicsBody?.linearDamping = 0.0
        boundary.physicsBody?.angularDamping = 0.0
        
        boundary.physicsBody?.categoryBitMask = boundaryCategory
        boundary.physicsBody?.contactTestBitMask = targetCategory | normalCategory
        boundary.physicsBody?.collisionBitMask = boundaryCategory | targetCategory | normalCategory
        
        objectFadeIn(object: boundary, pauseDuration: 1.4, duration: 3.0)

    
        self.addChild(boundary)
    }
    
    func addLabel(){
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.position = CGPoint(x: 0, y: 0)
        scoreLabel.zPosition = -1
        scoreLabel.fontColor = .white
        scoreLabel.fontSize = 200
        
        objectFadeIn(object: scoreLabel, pauseDuration: 3.0, duration: 3.4)
        
        self.addChild(scoreLabel)
    }
    
    func lives(middle: SKSpriteNode, left: SKSpriteNode, right: SKSpriteNode){
        

        livesArray = [middle, left, right]
        let livesPositioning : [ [CGFloat] ] = [ [frame.midX, frame.midY - 25], [frame.midX - 40,frame.midY -  25], [frame.midX + 40,frame.midY - 25]]
        
        for n in 0...2{
            livesArray[n] = SKSpriteNode.init(imageNamed: "heartLives")
            livesArray[n].position = CGPoint(x: livesPositioning[n][0], y: livesPositioning[n][1])
            livesArray[n].size = CGSize(width: 40, height: 40)
            
            objectFadeIn(object: livesArray[n], pauseDuration: 4.3, duration: 3.3)
            
            
            self.addChild(livesArray[n])
        }
        

        
    }
    
 
}
