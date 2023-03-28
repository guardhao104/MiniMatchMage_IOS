//
//  Player.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-03-23.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    var player:SKSpriteNode!

    private var playerAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Player1Animation")
    }
    
    private var playerTexture: SKTexture {
        return playerAtlas.textureNamed("Player1Animation")
    }
    
    // add enemy idle animation into fairyAtlas
    private var playerIdleTextures: [SKTexture] {
        return [
            playerAtlas.textureNamed("idle_1"),
            playerAtlas.textureNamed("idle_2"),
            playerAtlas.textureNamed("idle_3"),
            playerAtlas.textureNamed("idle_4")
        ]
    }
    
    // add enemy attack animation into fairyAtlas
    private var playerAttackTextures: [SKTexture] {
        return [
            playerAtlas.textureNamed("attack_1"),
            playerAtlas.textureNamed("attack_2"),
            playerAtlas.textureNamed("attack_3"),
            playerAtlas.textureNamed("attack_4"),
            playerAtlas.textureNamed("attack_5")
        ]
    }
    
    // set up the fairy image
    func setup(size:CGSize, pos:CGPoint) {
        // set the texture size
        player = SKSpriteNode(texture: playerTexture, size: size)
        // set the texture position
        player.position = CGPoint(x: pos.x, y: pos.y)
        
        addChild(player)
    }
    
    // trigger enemy idle animation
    func startPlayerIdleAnimation() {
        let idleAnimation = SKAction.animate(with: playerIdleTextures, timePerFrame: 0.1)
        
        player.run(SKAction.repeatForever(idleAnimation), withKey: "playerIdleTextures")
    }
    
    // trigger player attack animation
    func startPlayerAttackAnimation() {
        // set the animation duration
        let attackAnimation = SKAction.animate(with: playerAttackTextures, timePerFrame: 0.1)
        
        player.run(attackAnimation, completion: {
            // When the animation is complete, start the idle animation
            self.startPlayerAttackAnimation()
        })
        
    }
}
