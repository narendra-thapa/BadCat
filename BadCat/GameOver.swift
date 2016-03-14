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

}
