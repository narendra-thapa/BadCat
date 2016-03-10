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
        return projectile
    }
    
    func projectileAnimation() {
        let textures = [SKTexture(imageNamed: "projectile_1"), SKTexture(imageNamed: "projectile_2"), SKTexture(imageNamed: "projectile_3")]
        let projectileAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let projectileRepeat = SKAction.repeatActionForever(projectileAnimation)
        self.runAction(projectileRepeat)
    }
    
}
