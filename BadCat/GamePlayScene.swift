//
//  GamePlayScene.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class GamePlayScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = UIColor.grayColor()
                
        let backgroundNode = SKSpriteNode.init(imageNamed: "background_1")
        backgroundNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        backgroundNode.size = self.size
        self.addChild(backgroundNode)
    }
}
