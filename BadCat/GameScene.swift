//
//  GameScene.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-08.
//  Copyright (c) 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = UIColor.grayColor()
/*
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
*/
        let greenNode = SKSpriteNode.init(color: UIColor.greenColor(), size: CGSizeMake(10, 100))
     //   greenNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        greenNode.position = CGPointMake(10, 10)
        greenNode.anchorPoint = CGPointMake(0, 0)
        self.addChild(greenNode)
        
        let redNode = SKSpriteNode.init(color: UIColor.redColor(), size: CGSizeMake(100, 10))
     //   redNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        redNode.position = CGPointMake(10, 10)
        redNode.anchorPoint = CGPointMake(0, 0)
        self.addChild(redNode)
        
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
