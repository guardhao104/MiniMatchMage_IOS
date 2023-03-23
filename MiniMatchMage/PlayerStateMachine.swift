//
//  PlayerStateMachine.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-02-21.
//

import Foundation
import GameplayKit

fileprivate let characterAnimationKey = "Sprite Animation"

class PlayerState: GKState {
    unowned var playerNode: SKNode
    
    init(playerNode : SKNode) {
        self.playerNode = playerNode
        
        super.init()
    }
    
    var player : SKSpriteNode!
    
    private var playerAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Player1Animation")
    }
    
    private var playerTexture: SKTexture {
        return playerAtlas.textureNamed("Player1Animation")
    }
    
    private var playerAttackTextures: [SKTexture] {
        return [
            playerAtlas.textureNamed("attack_1"),
            playerAtlas.textureNamed("attack_2"),
            playerAtlas.textureNamed("attack_3"),
            playerAtlas.textureNamed("attack_4"),
            playerAtlas.textureNamed("attack_5")
        ]
    }
    
    private var playerIdleTextures: [SKTexture] {
        return [
            playerAtlas.textureNamed("idle_1"),
            playerAtlas.textureNamed("idle_2"),
            playerAtlas.textureNamed("idle_3"),
            playerAtlas.textureNamed("idle_4")
        ]
    }
    
    // set up the image
    private func setupPlayerIdle() {
        // set the texture size
        player = SKSpriteNode(texture: playerTexture, size: CGSize(width: 350, height: 350))
      // set the texture position
        player.position = CGPoint(x: -250, y: 100)
        
//        addChild(player)
    }
    
    func startAttackAnimation() {
        // set the animation duration
        let attackAnimation = SKAction.animate(with: playerAttackTextures, timePerFrame: 0.1)

        // run the animation
        player.run(SKAction.repeatForever(attackAnimation), withKey: "playerAttackTextures")
    }

    func startIdleAnimation() {
        // set the animation duration
        let idleAnimation = SKAction.animate(with: playerIdleTextures, timePerFrame: 0.1)

        // run the animation
        player.run(SKAction.repeatForever(idleAnimation), withKey: "playerIdleTextures")
    }
}
