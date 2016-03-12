//
//  TitleScene.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit
import AVFoundation

class TitleScene: SKScene {
    
    var pressStartSFX = SKAction()
    
    var backgroundMusic = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = UIColor.grayColor()
        
        let backgroundNode = SKSpriteNode.init(imageNamed: "splash_1")
        backgroundNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        backgroundNode.size = self.size
        self.addChild(backgroundNode)
        
        self.pressStartSFX = SKAction.playSoundFileNamed("PressStart.caf", waitForCompletion: false)
        
        let url = NSBundle.mainBundle().URLForResource("StartScreen", withExtension: "mp3")
        
        self.backgroundMusic = try! AVAudioPlayer(contentsOfURL: url!)
        self.backgroundMusic.numberOfLoops = -1
        self.backgroundMusic.prepareToPlay()
        self.backgroundMusic.play()
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.runAction(self.pressStartSFX)
        self.backgroundMusic.stop()
        let gamePlayScene = GamePlayScene()
        gamePlayScene.size = self.size
        let transition = SKTransition.fadeWithDuration(1.0)
        self.view?.presentScene(gamePlayScene, transition: transition)
    }

}