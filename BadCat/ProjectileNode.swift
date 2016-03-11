//
//  ProjectileNode.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-09.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class ProjectileNode: SKSpriteNode {

    func projectileAtPosition(position: CGPoint) -> ProjectileNode {
        let projectile = ProjectileNode.init(imageNamed: "projectile_1")
        projectile.position = position
        projectile.name = "Projectile"
        projectile.projectileAnimation()
        projectile.setupPhysicsBody()
        return projectile
    }
    
    func setupPhysicsBody() {
        self.physicsBody = SKPhysicsBody.init(rectangleOfSize: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        
        self.physicsBody?.categoryBitMask = UInt32(Constants.CollisionProjectile)
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = UInt32(Constants.CollisionEnemy)

        
    }
    
    func projectileAnimation() {
        let textures = [SKTexture(imageNamed: "projectile_1"), SKTexture(imageNamed: "projectile_2"), SKTexture(imageNamed: "projectile_3")]
        let projectileAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let projectileRepeat = SKAction.repeatActionForever(projectileAnimation)
        self.runAction(projectileRepeat)
    }
    
    func moveTowardsPosition(position: CGPoint) {
        let slope = Float((position.y - self.position.y) / (position.x - self.position.x))
        let offScreenX: Float
        if position.x <= self.position.x {
            offScreenX = -10
        } else {
            offScreenX = Float(self.parent!.frame.size.width) + 10
        }
        
        let offScreenY = slope * offScreenX - slope * Float(self.position.x) + Float(self.position.y)
        let pointOffScreen  = CGPoint(x: CGFloat(offScreenX), y: CGFloat(offScreenY))
        
        let distanceA = Float(pointOffScreen.y - self.position.y)
        let distanceB = Float(pointOffScreen.x - self.position.x)
        let distanceC = sqrtf(powf(distanceA, 2) + powf(distanceB, 2))
        
        let time = distanceC / Constants.BCProjectile
        let waitToFade = time * 0.75
        let fadeTime = time - waitToFade
        
        let moveProjectile = SKAction.moveTo(pointOffScreen, duration: Double(time))
        self.runAction(moveProjectile)
        
        let sequence = [SKAction.waitForDuration(Double(waitToFade)), SKAction.fadeOutWithDuration(Double(fadeTime)), SKAction.removeFromParent()]
        self.runAction(SKAction.sequence(sequence))
        
    }
    
    
    
}
