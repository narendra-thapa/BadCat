//
//  Constants.swift
//  BadCat
//
//  Created by Narendra Thapa on 2016-03-10.
//  Copyright © 2016 Narendra Thapa. All rights reserved.
//

import UIKit

struct Constants {
    static let BCProjectile: Float = 200
    
    static let CollisionEnemy       = 1 << 0    // 0000
    static let CollisionProjectile  = 1 << 1    // 0010
    static let CollisionDebris      = 1 << 2    // 0100
    static let CollisionGround      = 1 << 3    // 1000
    
    func randomWithMin(mini: Int, maxi: Int) -> Int {
        return Int(arc4random_uniform(UInt32(maxi - mini))) + mini
    }
    
}