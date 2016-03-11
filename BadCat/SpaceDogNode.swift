//
//  SpaceDogNode.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-10.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

enum SpaceDog {
    case SpaceDogTypeA
    case SpaceDogTypeB
}

class SpaceDogNode: SKSpriteNode {
    
    var instanceSpaceDog : SpaceDogNode?
    var textures : [SKTexture]?
    
    func spaceDogOfType(type: SpaceDog) -> SpaceDogNode {
        
        if type == SpaceDog.SpaceDogTypeA {
            instanceSpaceDog = SpaceDogNode.init(imageNamed : "spacedog_A_1")
            textures = [SKTexture(imageNamed: "spacedog_A_1"), SKTexture(imageNamed: "spacedog_A_2"), SKTexture(imageNamed: "spacedog_A_3")]
        } else {
            instanceSpaceDog = SpaceDogNode.init(imageNamed : "spacedog_B_1")
            textures = [SKTexture(imageNamed: "spacedog_B_1"), SKTexture(imageNamed: "spacedog_B_2"), SKTexture(imageNamed: "spacedog_B_3"), SKTexture(imageNamed: "spacedog_B_4")]
        }
        
        let animation = SKAction.animateWithTextures(textures!, timePerFrame: 0.1)
        instanceSpaceDog!.runAction(SKAction.repeatActionForever(animation))
        
        instanceSpaceDog?.setupPhysicsBody()
        
        return instanceSpaceDog!
    }
    
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody.init(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
        
        self.physicsBody?.categoryBitMask = UInt32(Constants.CollisionEnemy)
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = UInt32(Constants.CollisionProjectile) | UInt32(Constants.CollisionGround)
        
        
        
    }

}
