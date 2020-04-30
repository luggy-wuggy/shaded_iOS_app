//
//  Shapes.swift
//  shaded_proto
//
//  Created by Luqman Abdurrohman on 2/9/20.
//  Copyright © 2020 Luqman Abdurrohman. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


extension GameScene{
    
    func shape(xPosition: CGFloat, rgbValue: SKColor, targetBool: Bool, shape: Bool){
        let object : SKShapeNode
        
        if shape{
            object = SKShapeNode(circleOfRadius: 75)
            object.physicsBody = SKPhysicsBody(circleOfRadius: 75)
        }else{
            object = SKShapeNode(rectOf: CGSize(width: 155, height: 155), cornerRadius: 15)
            object.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 155, height: 155))
            
            // Rotation Attributes
            let rotationRandomizer : Int = Int.random(in: 0 ... 1)
            var rotate = SKAction()

            //Randomizes whether square rotates clockwise or counter clockwise
            if rotationRandomizer == 0 {
                rotate = SKAction.rotate(byAngle: 2.0 * CGFloat(-Double.pi), duration: 3.5)
            }else{
                rotate = SKAction.rotate(byAngle: 2.0 * CGFloat(Double.pi), duration: 3.5)
            }

            object.run(SKAction.repeatForever((rotate)))
        }
        
        object.position = CGPoint(x: xPosition, y: frame.maxY + 120)
        object.strokeColor = rgbValue
        //shape.fillColor = rgbValue
        object.glowWidth = 1.0
        object.lineWidth = 20
        
        object.physicsBody?.isDynamic = true
        object.physicsBody?.allowsRotation = false
        object.physicsBody?.pinned = false
        object.physicsBody?.affectedByGravity = true
        object.physicsBody?.friction = 0.0
        object.physicsBody?.restitution = 0.4     //BOUNCYINESS
        object.physicsBody?.linearDamping = 0.3
        object.physicsBody?.angularDamping = 0.2
        
        if targetBool{
             object.physicsBody?.categoryBitMask = targetCategory
             object.physicsBody?.contactTestBitMask = platformCategory | boundaryCategory
         }else{
             object.physicsBody?.categoryBitMask = normalCategory
             object.physicsBody?.contactTestBitMask = platformCategory | boundaryCategory
         }
         object.physicsBody?.collisionBitMask = platformCategory | boundaryCategory | targetCategory | normalCategory
         object.physicsBody?.usesPreciseCollisionDetection = true
    
        
        addChild(object)
    }

    
    
    @objc func triangleShape(xPosition: CGFloat, rgbValue: SKColor, targetBool: Bool){

        let cgPath = createRoundedTriangle(width: 200, height: 180, radius: 8)
        let path = UIBezierPath(cgPath: cgPath)
        
        let shape = SKShapeNode(path: path.cgPath)
        shape.position = CGPoint(x: xPosition, y: frame.maxY + 120)
        shape.strokeColor = rgbValue
        shape.glowWidth = 1.0
        shape.lineWidth = 20

        // Physics Attribute
        shape.physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
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

        // Rotation Attributes
        let rotationRandomizer : Int = Int.random(in: 0 ... 1)
        var rotate = SKAction()

        //Randomizes whether square rotates clockwise or counter clockwise
        if rotationRandomizer == 0 {
            rotate = SKAction.rotate(byAngle: 2.0 * CGFloat(-Double.pi), duration: 3.5)
        }else{
            rotate = SKAction.rotate(byAngle: 2.0 * CGFloat(Double.pi), duration: 3.5)
        }

        shape.run(SKAction.repeatForever((rotate)))

        self.addChild(shape)
    }


    func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
        let point1 = CGPoint(x: -width / 2, y: height / 2)
        let point2 = CGPoint(x: 0, y: -height / 2)
        let point3 = CGPoint(x: width / 2, y: height / 2)

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
        path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
        path.closeSubpath()

        return path
    }
        
    
    
    
    
    
    
    
    
}
