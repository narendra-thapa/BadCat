//
//  GamePlayScene.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-08.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit
import AVFoundation

class GamePlayScene: SKScene, SKPhysicsContactDelegate {
    
    
    var lastUpdateTimeInterval : NSTimeInterval = 0.0
    var timeSinceEnemyAdded : NSTimeInterval = 0.0
    var totalGameTime : NSTimeInterval = 0.0
    var minSpeed : Int = Constants.SpaceDogMinSpeed
    var addEnemyTimeInterval : NSTimeInterval = 1.5
    
    
    var damageSFX = SKAction()
    var explodeSFX = SKAction()
    var lazerSFX = SKAction()
    
    var backgroundMusic = AVAudioPlayer()
    
    var gameOver = Bool()
    var restart = Bool()
    var gameOverDisplayed = Bool()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    
        self.lastUpdateTimeInterval = 0
        self.timeSinceEnemyAdded = 0
        self.gameOver = false
        self.restart = false
        self.gameOverDisplayed = false
        
        self.backgroundColor = UIColor.grayColor()
                
        let backgroundNode = SKSpriteNode.init(imageNamed: "background_1")
        backgroundNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        backgroundNode.size = self.size
        backgroundNode.zPosition = 0
        self.addChild(backgroundNode)
        
        
        let machine = MachineNode()
        let machine1 = machine.machineAtPosition(CGPoint(x: CGRectGetMidX(self.frame), y: 12))
        machine1.zPosition = 1
        self.addChild(machine1)
        
        let spaceCat = SpaceCatNode()
        let spaceCat1 = spaceCat.spaceCatAtPosition(CGPoint(x: CGRectGetMidX(self.frame), y: 12))
        spaceCat1.zPosition = 2
        self.addChild(spaceCat1)
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        self.physicsWorld.contactDelegate = self
        
        let ground = GroundNode()
        let ground1 = ground.groundWithSize(CGSize(width: self.frame.size.width, height: 12))
        ground1.zPosition = 3
        self.addChild(ground1)
        
        self.setupSounds()
        
        self.backgroundMusic.play()
        
        let hud = HudNode()
        let hudNode = hud.hudAtPosition(CGPoint(x: 0, y: self.frame.size.height-20), inFrame: self.frame)
        self.addChild(hudNode)
        
        
    }
    
    func setupSounds() {
        self.damageSFX = SKAction.playSoundFileNamed("Damage.caf", waitForCompletion: false)
        self.explodeSFX = SKAction.playSoundFileNamed("Explode.caf", waitForCompletion: false)
        self.lazerSFX = SKAction.playSoundFileNamed("Laser.caf", waitForCompletion: false)
        
        let url = NSBundle.mainBundle().URLForResource("Gameplay", withExtension: "mp3")
        
        self.backgroundMusic = try! AVAudioPlayer(contentsOfURL: url!)
        self.backgroundMusic.numberOfLoops = -1
        self.backgroundMusic.prepareToPlay()
        
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !self.gameOver {
            for touch in touches {
                let position = touch.locationInNode(self)
                self.shootProjectileTowardsPosition(position)
            }
        } else if self.restart {
            
            for node in self.children {
                node.removeFromParent()
            }
            
            let scene = GamePlayScene(size: (self.view?.bounds.size)!)
            self.view?.presentScene(scene)
        }
    }
    
    func performGameOver() {
        let gameOver = GameOver()
        let gameOverNow = gameOver.gameOverAtPosition(CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)))
        self.addChild(gameOverNow)
        self.restart = true
        self.gameOverDisplayed = true
    }

    func shootProjectileTowardsPosition(position : CGPoint) {
        let spaceCat = self.childNodeWithName("SpaceCat") as! SpaceCatNode
        spaceCat.performTap()
        
        let machine = self.childNodeWithName("Machine") as! MachineNode

        let projectile = ProjectileNode()
        let projectile1 = projectile.projectileAtPosition(CGPoint(x: machine.position.x, y: machine.position.y + machine.frame.size.height-10))
        projectile1.zPosition = 4
        self.addChild(projectile1)
        
        projectile1.moveTowardsPosition(position)
        
        self.runAction(self.lazerSFX)
        
    }
    
    func addSpaceDog() {
        let constant = Constants()
        let randomSpaceDog = constant.randomWithMin(0, maxi: 2)
        
        let spaceDog = SpaceDogNode()
        let spaceDogA = spaceDog.spaceDogOfType(SpaceDog(rawValue: randomSpaceDog)!)
        let dy = constant.randomWithMin(Constants.SpaceDogMinSpeed, maxi: Constants.SpaceDogMaxSpeed)
        spaceDogA.physicsBody?.velocity = CGVector(dx: 0, dy: dy)
        
        let y = self.frame.size.height + spaceDogA.size.height
        let x = constant.randomWithMin(10 + Int(spaceDogA.size.width), maxi: Int(self.frame.size.width) - Int(spaceDogA.size.width) - 10)
        
        spaceDogA.position = CGPoint(x: CGFloat(x), y: y)
        spaceDogA.zPosition = 5
        self.addChild(spaceDogA)

    }
    
    override func update(currentTime: NSTimeInterval) {
        if (self.lastUpdateTimeInterval != 0) {
            self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval
            self.totalGameTime += currentTime - self.lastUpdateTimeInterval
        }
        
        if self.timeSinceEnemyAdded > self.addEnemyTimeInterval && !self.gameOver {
            self.addSpaceDog()
            self.timeSinceEnemyAdded = 0
        }
        
        self.lastUpdateTimeInterval = currentTime
        
        if self.totalGameTime > 480 {
            self.addEnemyTimeInterval = 0.5
            self.minSpeed = -160
        } else if self.totalGameTime > 240 {
            self.addEnemyTimeInterval = 0.55
            self.minSpeed = -145
        } else if self.totalGameTime > 120 {
            self.addEnemyTimeInterval = 0.65
            self.minSpeed = -130
        } else if self.totalGameTime > 60 {
            self.addEnemyTimeInterval = 0.75
            self.minSpeed = -115
        } else if self.totalGameTime > 30 {
            self.addEnemyTimeInterval = 1.00
            self.minSpeed = -100
        }
        
        if self.gameOver && !self.gameOverDisplayed {
            self.performGameOver()
        }
        
        
    }
    
    func addPoints(points: Int) {
        let hud = self.childNodeWithName("HUD") as! HudNode
        hud.addPoints(points)
    }
    
    func loseLife() {
        let hud = self.childNodeWithName("HUD") as! HudNode
        self.gameOver = hud.loseLife()
        
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
            
            self.addPoints(Constants.pointsPerHit)
            
            self.runAction(self.explodeSFX)
            
            let spaceDog = firstBody.node
            let projectile = secondBody.node
            spaceDog?.removeFromParent()
            projectile?.removeFromParent()
            
            
            
        } else if firstBody.categoryBitMask == UInt32(Constants.CollisionEnemy) && secondBody.categoryBitMask == UInt32(Constants.CollisionGround) {
            print("Hit Ground!")
            
            self.loseLife()
            
            self.runAction(self.damageSFX)
            
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
            debris.zPosition = 6
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
        
        let explosionPath = NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks")
        let explosion = NSKeyedUnarchiver.unarchiveObjectWithFile(explosionPath!) as! SKEmitterNode
        explosion.position = position
        explosion.zPosition = 7
        self.addChild(explosion)
        
        explosion.runAction(SKAction.waitForDuration(1.5), completion: { () -> Void in
            explosion.removeFromParent()
        })
        
    }
    
    
//    override func update(currentTime: NSTimeInterval) {
//        print(currentTime % 60)
//    }
    
    
}
