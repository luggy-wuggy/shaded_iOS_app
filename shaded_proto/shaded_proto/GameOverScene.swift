//
//  GameOverScene.swift
//  shaded_proto
//
//  Created by Luqman Abdurrohman on 1/11/20.
//  Copyright © 2020 Luqman Abdurrohman. All rights reserved.
//

import SpriteKit


class GameOverScene: SKScene {
    
    var score:Int = 0
    
    var scoreLabel:SKLabelNode!
    var playAgainButton:SKLabelNode!
    
    override func didMove(to view: SKView) {
        scoreLabel = (self.childNode(withName:"scoreLabel") as! SKLabelNode)
        scoreLabel.text = "\(score)"
        
        playAgainButton = (self.childNode(withName: "playAgainButton") as! SKLabelNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in:self){
            let node = self.nodes(at: location)
            
            if node[0].name == "playAgainButton"{
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene!.scaleMode = .aspectFill
                self.view!.presentScene(gameScene!, transition: transition)
            }
        }
        
    }

}
