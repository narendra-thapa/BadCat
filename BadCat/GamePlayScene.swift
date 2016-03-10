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
        
        
        let machine = MachineNode()
        let machine1 = machine.machineAtPosition(CGPoint(x: CGRectGetMidX(self.frame), y: 12))
        self.addChild(machine1)
        
        let spaceCat = SpaceCatNode()
        let spaceCat1 = spaceCat.spaceCatAtPosition(CGPoint(x: CGRectGetMidX(self.frame), y: 12))
        self.addChild(spaceCat1)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let position = touch.locationInNode(self)
            self.shootProjectileTowardsPosition(position)
        }
    }

    func shootProjectileTowardsPosition(position : CGPoint) {
        let spaceCat = self.childNodeWithName("SpaceCat") as! SpaceCatNode
        spaceCat.performTap()

        let projectile = ProjectileNode()
        let projectile1 = projectile.projectileAtPosition(position)
        self.addChild(projectile1)
        
    }
    
    
//    override func update(currentTime: NSTimeInterval) {
//        print(currentTime % 60)
//    }
    
    
}
