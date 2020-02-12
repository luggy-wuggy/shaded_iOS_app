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
import AVFoundation

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
    var highScore = UserDefaults.standard
    
   
    var collisionSoundEffect: AVAudioPlayer?

    
        
    var gameTimer:Timer!
    
    let boundaryCategory:UInt32 = 0x1 << 3
    let normalCategory:UInt32 = 0x1 << 2
    let targetCategory:UInt32 = 0x1 << 1
    let platformCategory:UInt32 = 0x1 << 0
    
    var timer:Timer? = nil
    var times:Int = 0
    
    var AudioPlayer = AVAudioPlayer()
    
    
    override func didMove(to view: SKView) {
        
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "synth_background", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = -1
        AudioPlayer.play()
        AudioPlayer.setVolume(0.50, fadeDuration: 4.5)

        
        //highScore.set(10, forKey: "HIGHSCORE")
                
        addBoundary()
        addPlatform()
        addLabel()
        lives(middle: middle, left: left, right: right)
        

        
        let action = SKAction.sequence([SKAction.wait(forDuration: 6.0), SKAction.run {
            self.startTimer(timeInterval: 2.0)
            }])
        
        run(action)
        
        

        

        self.physicsWorld.contactDelegate = self
    }
    
    @objc func onTick(timer: Timer){
        times += 1
        
        if times < 8{
            threeShapes(shapes : true)
            self.startTimer(timeInterval: 2.0)
        }else if times < 15{
            threeShapes(shapes : false)
            self.startTimer(timeInterval: 1.8)
        }else if times < 20{
            threeShapes(shapes : false)
            self.startTimer(timeInterval: 1.6)
        }else if times < 26{
            threeShapes(shapes : false)
            self.startTimer(timeInterval: 1.4)
        }else if times < 32{
            threeShapes(shapes : false)
            self.startTimer(timeInterval: 1.2)
        }else if times < 38{
            threeShapes(shapes : false)
            self.startTimer(timeInterval: 1.0)
        }else{
            threeShapes(shapes : false)
            self.startTimer(timeInterval: 0.8)
        }
        
    }
    
    func startTimer(timeInterval: Double){
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector:  #selector(self.onTick), userInfo:  nil, repeats: false)
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


