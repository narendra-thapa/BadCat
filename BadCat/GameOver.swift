//
//  GameOver.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-13.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class GameOver: SKNode {
    
    func gameOverAtPosition(position: CGPoint) -> GameOver {
        let gameOver = GameOver()
        let gameOverLabel = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        gameOverLabel.name = "GameOver"
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 48
        gameOverLabel.position = position
        gameOverLabel.zPosition = 9
        gameOver.addChild(gameOverLabel)
        
        return gameOver
    }
    
    func performAnimation() {
        let label = self.childNodeWithName("GameOver") as! SKLabelNode
        label.xScale = 0
        label.yScale = 0
        let scaleUp = SKAction.scaleTo(1.2, duration: 0.75)
        let scaleDown = SKAction.scaleTo(0.9, duration: 0.25)
        
        let run = SKAction.runBlock { () -> Void in
            let touchToRestart = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
            touchToRestart.text = "Touch To Restart"
            touchToRestart.fontSize = 24
            touchToRestart.position = CGPoint(x: label.position.x, y: label.position.y - 40)
            touchToRestart.zPosition = 9
            self.addChild(touchToRestart)
        }
        
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown, run])
        label.runAction(scaleSequence)
        
    }

}
