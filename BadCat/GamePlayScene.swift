//
//  GamePlayScene.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class GamePlayScene: SKScene, SKPhysicsContactDelegate {
    
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
        
        self.addSpaceDog()
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        self.physicsWorld.contactDelegate = self
        
        let ground = GroundNode()
        let ground1 = ground.groundWithSize(CGSize(width: self.frame.size.width, height: 22))
        self.addChild(ground1)
        
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
        
        let machine = self.childNodeWithName("Machine") as! MachineNode

        let projectile = ProjectileNode()
        let projectile1 = projectile.projectileAtPosition(CGPoint(x: machine.position.x, y: machine.position.y + machine.frame.size.height-10))
        self.addChild(projectile1)
        
        projectile1.moveTowardsPosition(position)
        
    }
    
    func addSpaceDog() {
        let spaceDogA = SpaceDogNode()
        let spaceDogA1 = spaceDogA.spaceDogOfType(SpaceDog.SpaceDogTypeA)
        spaceDogA1.position = CGPoint(x: 100, y: 300)
        self.addChild(spaceDogA1)
        
        let spaceDogB = SpaceDogNode()
        let spaceDogB1 = spaceDogB.spaceDogOfType(SpaceDog.SpaceDogTypeB)
        spaceDogB1.position = CGPoint(x: 200, y: 300)
        self.addChild(spaceDogB1)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == UInt32(Constants.CollisionEnemy) && secondBody.categoryBitMask == UInt32(Constants.CollisionProjectile) {
            print("Bam!")
            let spaceDog = firstBody.node
            let projectile = secondBody.node
            spaceDog?.removeFromParent()
            projectile?.removeFromParent()
            
            
            
        } else if firstBody.categoryBitMask == UInt32(Constants.CollisionEnemy) && secondBody.categoryBitMask == UInt32(Constants.CollisionGround) {
            print("Hit Ground!")
            let spaceDog = firstBody.node
            spaceDog?.removeFromParent()
        }
        
        self.createDebrisAtPosition(contact.contactPoint)
        
    }
    
    func createDebrisAtPosition(position: CGPoint) {
        let numberOfPieces = Constants()
        let numberOfDebris = numberOfPieces.randomWithMin(5, maxi: 20)
        var i = Int()
        let imageName = String()
        for (i = 0;i < numberOfDebris; i++){
            let randomPiece = numberOfPieces.randomWithMin(1, maxi: 4)
            let imageName = imageName.stringByAppendingFormat("debri_\(randomPiece)")
            
            let debris = SKSpriteNode.init(imageNamed: imageName)
            debris.position = position
            self.addChild(debris)
            
            debris.physicsBody = SKPhysicsBody.init(rectangleOfSize: debris.frame.size)
            debris.physicsBody?.categoryBitMask = UInt32(Constants.CollisionDebris)
            debris.physicsBody?.contactTestBitMask = 0
            debris.physicsBody?.collisionBitMask = UInt32(Constants.CollisionGround) | UInt32(Constants.CollisionDebris)
            debris.name = "Debris"
            
            debris.physicsBody?.velocity = CGVector(dx: numberOfPieces.randomWithMin(-150, maxi: 150), dy: numberOfPieces.randomWithMin(150, maxi: 350))
            
            debris.runAction(SKAction.waitForDuration(1.5), completion: { () -> Void in
                debris.removeFromParent()
            })
            
        }
    }
    
    
//    override func update(currentTime: NSTimeInterval) {
//        print(currentTime % 60)
//    }
    
    
}
