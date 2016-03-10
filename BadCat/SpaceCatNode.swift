//
//  SpaceCatNode.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-09.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class SpaceCatNode: SKSpriteNode {
    
    var machine : SpaceCatNode?
    
    func spaceCatAtPosition(position: CGPoint) -> SpaceCatNode {
        self.machine = SpaceCatNode.init(imageNamed: "spacecat_1")
        self.machine?.position = position
        self.machine?.anchorPoint = CGPointMake(0.5, 0)
        self.machine?.name = "SpaceCat"
        return self.machine!
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
