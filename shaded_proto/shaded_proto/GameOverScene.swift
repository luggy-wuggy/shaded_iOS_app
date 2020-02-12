//
//  GameOverScene.swift
//  shaded_proto
//
//  Created by Luqman Abdurrohman on 1/11/20.
//  Copyright © 2020 Luqman Abdurrohman. All rights reserved.
//

import SpriteKit
import AVFoundation


class GameOverScene: SKScene {
    
    var score:Int = 0
    var highScore:Int = 0

    
    var scoreLabel:SKLabelNode!
    var playAgainButton:SKLabelNode!
    var highScoreLabel:SKLabelNode!
    
    var AudioPlayer = AVAudioPlayer()

    override func didMove(to view: SKView) {
        
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource:"game_over_background", ofType: "mp3")!)
        
        AudioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = -1
        AudioPlayer.play()
        AudioPlayer.setVolume(0.50, fadeDuration: 4.5)

        scoreLabel = (self.childNode(withName:"scoreLabel") as! SKLabelNode)
        scoreLabel.text = "\(score)"
        
        highScoreLabel = (self.childNode(withName: "highScoreLabel") as! SKLabelNode)
        highScoreLabel.text = "\(highScore)"
        
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
