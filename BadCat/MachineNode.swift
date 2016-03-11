//
//  MachineNode.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-09.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import SpriteKit

class MachineNode: SKSpriteNode {
    
    
    func machineAtPosition(position: CGPoint) -> MachineNode {
        let machine = MachineNode.init(imageNamed: "machine_1")
        machine.position = position
        machine.anchorPoint = CGPointMake(0.5, 0)
        machine.name = "Machine"
        
        
        let textures = [SKTexture(imageNamed: "machine_2"), SKTexture(imageNamed: "machine_1")]
        let machineAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let machineRepeat = SKAction.repeatActionForever(machineAnimation)
        
        machine.runAction(machineRepeat)
        
        return machine
    }
}
