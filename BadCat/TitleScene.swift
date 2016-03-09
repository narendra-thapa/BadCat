//
//  TitleScene.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class TitleScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = UIColor.grayColor()
        
        let backgroundNode = SKSpriteNode.init(imageNamed: "splash_1")
        backgroundNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        backgroundNode.size = self.size
        self.addChild(backgroundNode)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let gamePlayScene = GamePlayScene()
        let transition = SKTransition.fadeWithDuration(1.0)
        self.view?.presentScene(gamePlayScene, transition: transition)
    }

}