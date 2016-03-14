//
//  HudNode.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-12.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class HudNode: SKNode {
    
    var lives : Int = Constants.SpaceCatLives
    var score : Int = 0
    
    func hudAtPosition(position : CGPoint, inFrame : CGRect) -> HudNode {
        
        
        let hud = HudNode()
        hud.position = position
        hud.zPosition = 8
        hud.name = "HUD"
        
        let catHead = SKSpriteNode.init(imageNamed: "HUD_cat_1")
        catHead.position = CGPoint(x: 30, y: -10)
        hud.addChild(catHead)
        
        hud.lives = Constants.SpaceCatLives
        
        var lastLifeBar : SKSpriteNode!
        
        for (var i = 0; i < hud.lives; i++) {
            let lifeBar = SKSpriteNode.init(imageNamed: "HUD_life_1")
            lifeBar.name = String(format: "Life%d", i+1)
            hud.addChild(lifeBar)
            
            if lastLifeBar == nil {
                lifeBar.position = CGPoint(x: catHead.position.x+30, y: catHead.position.y)
            } else {
                lifeBar.position = CGPoint(x: lastLifeBar.position.x+10, y: lastLifeBar.position.y)
            }
            
            lastLifeBar = lifeBar
        }
        
        let scoreLabel = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        scoreLabel.name = "Score"
        scoreLabel.text = "0"
        scoreLabel.fontSize = 24
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        scoreLabel.position = CGPoint(x: inFrame.size.width-20, y: -10)
        hud.addChild(scoreLabel)
        
        return hud
    }
    
    func addPoints(points: Int) {
        self.score += points
        
        let scoreLabel = self.childNodeWithName("Score") as! SKLabelNode
        scoreLabel.text = String(format: "%d", self.score)
        
    }
    
    func loseLife() -> Bool {
        if self.lives > 0 {
            let lifeNodeName = String(format: "Life%d", self.lives)
            let lifeToRemove = self.childNodeWithName(lifeNodeName)
            lifeToRemove?.removeFromParent()
            self.lives--
        }
        
        return self.lives == 0
    }
    

}
