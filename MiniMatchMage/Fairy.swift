//
//  Enemy.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-03-23.
//

import Foundation
import SpriteKit

class Fairy: Enemy {
    
    private var fairyAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Fairy")
    }
    
    private var fairyTexture: SKTexture {
        return fairyAtlas.textureNamed("Fairy")
    }
    
    // add enemy idle animation into fairyAtlas
    private var fairyIdleTextures: [SKTexture] {
        return [
            fairyAtlas.textureNamed("enemy_1_idle_0"),
            fairyAtlas.textureNamed("enemy_1_idle_1"),
            fairyAtlas.textureNamed("enemy_1_idle_2"),
            fairyAtlas.textureNamed("enemy_1_idle_3"),
            fairyAtlas.textureNamed("enemy_1_idle_4"),
            fairyAtlas.textureNamed("enemy_1_idle_5"),
            fairyAtlas.textureNamed("enemy_1_idle_6"),
            fairyAtlas.textureNamed("enemy_1_idle_7"),
            fairyAtlas.textureNamed("enemy_1_idle_8")
        ]
    }
    
    // add enemy attack animation into fairyAtlas
    private var fairyAttackTextures: [SKTexture] {
        return [
            fairyAtlas.textureNamed("enemy_1_attack_0"),
            fairyAtlas.textureNamed("enemy_1_attack_1"),
            fairyAtlas.textureNamed("enemy_1_attack_2"),
            fairyAtlas.textureNamed("enemy_1_attack_3"),
            fairyAtlas.textureNamed("enemy_1_attack_4"),
            fairyAtlas.textureNamed("enemy_1_attack_5"),
            fairyAtlas.textureNamed("enemy_1_attack_6"),
            fairyAtlas.textureNamed("enemy_1_attack_7"),
            fairyAtlas.textureNamed("enemy_1_attack_8"),
            fairyAtlas.textureNamed("enemy_1_attack_9"),
            fairyAtlas.textureNamed("enemy_1_attack_10")
        ]
    }
    
    private var fairyHitTextures: [SKTexture] {
        return [
            fairyAtlas.textureNamed("enemy_1_hit_0"),
            fairyAtlas.textureNamed("enemy_1_hit_1"),
            fairyAtlas.textureNamed("enemy_1_hit_2"),
            fairyAtlas.textureNamed("enemy_1_hit_3"),
            fairyAtlas.textureNamed("enemy_1_hit_4"),
            fairyAtlas.textureNamed("enemy_1_hit_5"),
            fairyAtlas.textureNamed("enemy_1_hit_6"),
            fairyAtlas.textureNamed("enemy_1_hit_7"),
            fairyAtlas.textureNamed("enemy_1_hit_8"),
            fairyAtlas.textureNamed("enemy_1_hit_9")
        ]
    }
    
    // set up the fairy image
    func setupEnemy(width: CGFloat, height: CGFloat, pos: CGPoint) {
        // Use subclass-specific textures fairyTexture
        super.setup(texture: fairyTexture, width: width, height: height, pos: pos)
    }
    
    // trigger enemy idle animation
    override func startIdleAnimation() {
        super.triggerAnimation(texture:fairyIdleTextures, key:"fairyIdleTextures")
    }
    
    // trigger enemy attack animation
    override func startAttackAnimation() {
        super.triggerAnimation(texture:fairyAttackTextures, key:"fairyAttackTextures")
        
        // set the animation duration
        let attackAnimation = SKAction.animate(with: fairyAttackTextures, timePerFrame: 0.1)
        
        // When the attack animation is complete, wait for 0.5 seconds, then start the idle animation
        enemy.run(attackAnimation, completion: {
            let waitAction = SKAction.wait(forDuration: 0.5)
            let idleAction = SKAction.run {
                self.startIdleAnimation()
            }
            let sequence = SKAction.sequence([waitAction, idleAction])
            self.run(sequence)
        })
    }
    
    // trigger animation when get hit
    override func startHitAnimation() {
        super.triggerAnimation(texture:fairyHitTextures, key:"fairyHitTextures")
        
        // set the animation duration
        let attackAnimation = SKAction.animate(with: fairyHitTextures, timePerFrame: 0.1)
        
        // When the attack animation is complete, wait for 0.5 seconds, then start the idle animation
        enemy.run(attackAnimation, completion: {
            let waitAction = SKAction.wait(forDuration: 0.5)
            let idleAction = SKAction.run {
                self.startIdleAnimation()
            }
            let sequence = SKAction.sequence([waitAction, idleAction])
            self.run(sequence)
        })
    }
}
