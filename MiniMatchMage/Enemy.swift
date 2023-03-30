//
//  Enemy.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-03-23.
//

import Foundation
import SpriteKit

class Enemy:SKSpriteNode {
    var enemy:SKSpriteNode!
    
    // set up the fairy image
    func setup(texture:SKTexture, width:CGFloat, height:CGFloat, pos:CGPoint) {
        // set the texture size
        enemy = SKSpriteNode(texture: texture, size: CGSize(width: width, height: height))
        // set the texture position
        enemy.position = CGPoint(x: pos.x, y: pos.y)

        addChild(enemy)
    }
    
    // trigger enemy animation
    func triggerAnimation(texture:[SKTexture], key:String) {
        let animation = SKAction.animate(with: texture, timePerFrame: 0.1)

        enemy.run(SKAction.repeatForever(animation), withKey: key)
    }
}
