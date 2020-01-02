//
//  GameFunctions.swift
//  shaded_proto
//
//  Created by Luqman Abdurrohman on 1/1/20.
//  Copyright © 2020 Luqman Abdurrohman. All rights reserved.
//

import GameplayKit
import SpriteKit

extension GameScene{
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody
        var secondBody : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & targetCategory) != platformCategory && (secondBody.categoryBitMask & platformCategory) != targetCategory{
            targetShapeCollide(platformNode: firstBody.node as! SKShapeNode, shapeNode: secondBody.node as! SKShapeNode)
        }else{
            normalShapeCollide(platformNode: firstBody.node as! SKShapeNode, shapeNode: secondBody.node as! SKShapeNode)
        }
        
    }
    
    func targetShapeCollide (platformNode: SKShapeNode, shapeNode: SKShapeNode){
        
        let collision = [SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]
        shapeNode.run(SKAction.sequence(collision))
        
        score += 1
        
    }
    
    func normalShapeCollide (platformNode: SKShapeNode, shapeNode: SKShapeNode){
        
        let collision = [SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]
        shapeNode.run(SKAction.sequence(collision))
        
        score -= 1
        
    }
    
//    func torpedoDidCollideWithAlien (torpedoNode:SKSpriteNode, alienNode:SKSpriteNode) {
//
//        let explosion = SKEmitterNode(fileNamed: "Explosion")!
//        explosion.position = alienNode.position
//        self.addChild(explosion)
//
//        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
//
//        torpedoNode.removeFromParent()
//        alienNode.removeFromParent()
//
//
//        self.run(SKAction.wait(forDuration: 2)) {
//            explosion.removeFromParent()
//        }
//
//        score += 5
//
//
//    }
    
    
    func createRGB_Values() -> [Array<CGFloat>] {
          
          // rgbValues: Declares an array of CGFloat between 0 ... 1 to denote RGB values
          // rgbValues_Target: Declares an array of CGFloat using the values from rgbValues array
          let rgbValues: [CGFloat] = [CGFloat.random(in: 0.00 ... 1.00), CGFloat.random(in: 0.00 ... 1.00), CGFloat.random(in: 0.00 ... 1.00)]
          var rgbValues_Target: [CGFloat] = [0.0,0.0,0.0]
          
          for color in 0...2{
              var newColorValue = rgbValues[color] + 0.10
              if newColorValue > 1.0{
                  newColorValue = rgbValues[color]
              }
              rgbValues_Target[color] = newColorValue
          }
          
          let rgbPackage = [rgbValues, rgbValues_Target]
          
          return rgbPackage
      }
    
    
}
