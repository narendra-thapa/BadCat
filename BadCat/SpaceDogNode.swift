//
//  SpaceDogNode.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-10.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

enum SpaceDog: Int {
    case SpaceDogTypeA = 0
    case SpaceDogTypeB = 1
}

class SpaceDogNode: SKSpriteNode {
    
    var instanceSpaceDog : SpaceDogNode?
    var textures : [SKTexture]?
    
    func spaceDogOfType(type: SpaceDog) -> SpaceDogNode {
        
        if type == SpaceDog.SpaceDogTypeA {
            instanceSpaceDog = SpaceDogNode.init(imageNamed : "spacedog_A_1")
            textures = [SKTexture(imageNamed: "spacedog_A_1"), SKTexture(imageNamed: "spacedog_A_2")]
        } else {
            instanceSpaceDog = SpaceDogNode.init(imageNamed : "spacedog_B_1")
            textures = [SKTexture(imageNamed: "spacedog_B_1"), SKTexture(imageNamed: "spacedog_B_2"), SKTexture(imageNamed: "spacedog_B_3")]
        }
        
        let constant = Constants()
        let scale = Double(constant.randomWithMin(85, maxi: 100)) / 100.0
        
        instanceSpaceDog?.xScale = CGFloat(scale)
        instanceSpaceDog?.yScale = CGFloat(scale)
        
        let animation = SKAction.animateWithTextures(textures!, timePerFrame: 0.1)
        instanceSpaceDog!.runAction(SKAction.repeatActionForever(animation))
        
        instanceSpaceDog?.setupPhysicsBody()
        
        return instanceSpaceDog!
    }
    
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody.init(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        
        
        self.physicsBody?.categoryBitMask = UInt32(Constants.CollisionEnemy)
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = UInt32(Constants.CollisionProjectile) | UInt32(Constants.CollisionGround)
        
        
        
    }

}
