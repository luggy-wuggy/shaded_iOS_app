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
        var firstBody = contact.bodyA
        var secondBody : SKPhysicsBody
        
        if firstBody.categoryBitMask == platformCategory{
            if contact.bodyB.categoryBitMask == targetCategory{
                secondBody = contact.bodyB
                targetShapeCollide(shapeNode: secondBody.node as! SKShapeNode)
            }else if (contact.bodyB.categoryBitMask == normalCategory){
                secondBody = contact.bodyB
                normalShapeCollide(shapeNode: secondBody.node as! SKShapeNode)
            }
        }
        
        if firstBody.categoryBitMask == boundaryCategory{
            firstBody = contact.bodyA
            boundaryCollide(shapeNode: contact.bodyB.node as! SKShapeNode)
        }

        
    }
    

    func targetShapeCollide (shapeNode: SKShapeNode){
        
        let collision = [SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]
        shapeNode.run(SKAction.sequence(collision))
        
        score += 1
        
    }
    
    func normalShapeCollide (shapeNode: SKShapeNode){
        score -= 1
        
        shakeCamera(shape: shapeNode, duration: 1.0)
        let collision = [SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]
        shapeNode.run(SKAction.sequence(collision))
        
        if livesArray.count != 0{
            let life = livesArray.popLast()!
            life.run(SKAction.removeFromParent())
        }
        

        if livesArray.count == 0 {
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOver = SKScene(fileNamed: "GameOverScene") as! GameOverScene
            gameOver.score = self.score
            self.view?.presentScene(gameOver, transition: transition)
        }

        
        
    }
    
    func boundaryCollide (shapeNode: SKShapeNode){
        let collision = [SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]
        shapeNode.run(SKAction.sequence(collision))
    }
    
    func shakeCamera(shape: SKShapeNode, duration:Float) {

        let amplitudeX:Float = 20;
        let amplitudeY:Float = 12;
        let numberOfShakes = duration / 0.04;
        var actionsArray:[SKAction] = [];
        for _ in 1...Int(numberOfShakes) {
            let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
            let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
            let shakeAction = SKAction.moveBy(x: CGFloat(moveX), y: CGFloat(moveY), duration: 0.02);
            shakeAction.timingMode = SKActionTimingMode.easeOut;
            actionsArray.append(shakeAction);
            actionsArray.append(shakeAction.reversed());
        }

        let actionSeq = SKAction.sequence(actionsArray);
        shape.run(actionSeq);
        scoreLabel.run(actionSeq);
        platform.run(actionSeq);
        boundary.run(actionSeq);
        for live in livesArray{
            live.run(actionSeq);
        }
        
   
    }
    
 
    
    
    
    func objectFadeIn(object: SKNode, pauseDuration: Double = 2.0, duration: Double = 5.0){
        object.alpha = 0.0
        let fade = [SKAction.wait(forDuration: pauseDuration), SKAction.fadeAlpha(to: 1.0, duration: duration)]
        object.run(SKAction.sequence(fade))
    }
    
    // acceleration
    func timerDrop(interval: Double, probablity: Int){
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true){ timer in
            
            self.threeShapes()
            let randomNumber = Int.random(in: 1 ... probablity)
            if randomNumber == 10{
                timer.invalidate()
            }
            
        }
    }
    
    func createRGB_Values() -> [Array<CGFloat>] {
          
        // rgbValues: Declares an array of CGFloat between 0 ... 1 to denote RGB values
        // rgbValues_Target: Declares an array of CGFloat using the values from rgbValues array
        let rgbValues: [CGFloat] = [CGFloat.random(in: 0.00 ... 1.00), CGFloat.random(in: 0.00 ... 1.00), CGFloat.random(in: 0.00 ... 1.00)]
        var rgbValues_Target: [CGFloat] = [0.0,0.0,0.0]
          
        let rgbDiff = Bool.random()
        var newColorValue : CGFloat
        
        for color in 0...2{
            
            if rgbDiff{
                
                newColorValue = rgbValues[color] + 0.15
                if newColorValue > 1.0{
                    newColorValue = rgbValues[color]
                }
                
                rgbValues_Target[color] = newColorValue
                
                
            }else{
                
                newColorValue = rgbValues[color] - 0.15
                if newColorValue < 0.0{
                    newColorValue = rgbValues[color]
                }
                
                rgbValues_Target[color] = newColorValue
                
            }
            
            
        }
          
        let rgbPackage = [rgbValues, rgbValues_Target]
          
        return rgbPackage
      }
    
    
}
