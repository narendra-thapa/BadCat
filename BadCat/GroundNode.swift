//
//  GroundNode.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-10.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class GroundNode: SKSpriteNode {
    
    func groundWithSize(sizee: CGSize) -> GroundNode {
        let newground = GroundNode()
        let ground = newground.dynamicType.init(color: UIColor.clearColor(), size: sizee)
        //init(texture: SKTexture.init(imageNamed: "debri_1"), color: UIColor.greenColor(), size: sizee)
        ground.name = "Ground"
        
        ground.position = CGPointMake(sizee.width/2, sizee.height/2)
        
        ground.setupPhysicsBody()
        return ground
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody.init(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = false
        
        self.physicsBody?.categoryBitMask = UInt32(Constants.CollisionGround)
        self.physicsBody?.collisionBitMask = UInt32(Constants.CollisionDebris)
        self.physicsBody?.contactTestBitMask = UInt32(Constants.CollisionEnemy)
    }

}
