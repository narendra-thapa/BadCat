//
//  SpaceCatNode.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-09.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class SpaceCatNode: SKSpriteNode {
    
    var spaceCat : SpaceCatNode?
    
    func spaceCatAtPosition(position: CGPoint) -> SpaceCatNode {
        self.spaceCat = SpaceCatNode.init(imageNamed: "spacecat_1")
        self.spaceCat?.position = position
        self.spaceCat?.anchorPoint = CGPointMake(0.5, 0)
        self.spaceCat?.name = "SpaceCat"
        return self.spaceCat!
    }
    
    func performTap() {
        self.runAction(tapAction())
    }
    
    func tapAction() -> SKAction {
        print("Tapped")
        let textures = [SKTexture(imageNamed: "spacecat_2"), SKTexture(imageNamed: "spacecat_1")]
        let machineAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
        return machineAnimation
    }

}
