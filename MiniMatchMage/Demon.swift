//
//  Demon.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-03-27.
//

import Foundation
import SpriteKit

class Demon: Enemy {
    
    private var demonAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Demon")
    }
    
    private var catWitchTexture: SKTexture {
        return demonAtlas.textureNamed("Demon")
    }
    
    // add enemy idle animation into fairyAtlas
    private var demonIdleTextures: [SKTexture] {
        return [
            demonAtlas.textureNamed("demon_idle_0"),
            demonAtlas.textureNamed("demon_idle_1"),
            demonAtlas.textureNamed("demon_idle_2"),
            demonAtlas.textureNamed("demon_idle_3"),
            demonAtlas.textureNamed("demon_idle_4"),
            demonAtlas.textureNamed("demon_idle_5"),
            demonAtlas.textureNamed("demon_idle_6")
        ]
    }
    
    // add enemy attack animation into fairyAtlas
    private var demonAttackTextures: [SKTexture] {
        return [
            demonAtlas.textureNamed("demon_attack_0"),
            demonAtlas.textureNamed("demon_attack_1"),
            demonAtlas.textureNamed("demon_attack_2"),
            demonAtlas.textureNamed("demon_attack_3"),
            demonAtlas.textureNamed("demon_attack_4"),
            demonAtlas.textureNamed("demon_attack_5"),
            demonAtlas.textureNamed("demon_attack_6"),
            demonAtlas.textureNamed("demon_attack_7"),
            demonAtlas.textureNamed("demon_attack_8"),
            demonAtlas.textureNamed("demon_attack_9"),
            demonAtlas.textureNamed("demon_attack_10")
        ]
    }
    
    private var demonHitTextures: [SKTexture] {
        return [
            demonAtlas.textureNamed("demon_hit_0"),
            demonAtlas.textureNamed("demon_hit_1"),
            demonAtlas.textureNamed("demon_hit_2"),
            demonAtlas.textureNamed("demon_hit_3"),
            demonAtlas.textureNamed("demon_hit_4"),
            demonAtlas.textureNamed("demon_hit_5"),
            demonAtlas.textureNamed("demon_hit_6"),
            demonAtlas.textureNamed("demon_hit_7")
        ]
    }
    
    // set up the fairy image
    func setupEnemy(width: CGFloat, height: CGFloat, pos: CGPoint) {
        // Use subclass-specific textures fairyTexture
        super.setup(texture: catWitchTexture, width: width, height: height, pos: pos)
    }
    
    // trigger enemy idle animation
    override func startIdleAnimation() {
        super.triggerAnimation(texture:demonIdleTextures, key:"demonIdleTextures")
    }
    
    // trigger enemy attack animation
    override func startAttackAnimation() {
        super.triggerAnimation(texture:demonAttackTextures, key:"demonAttackTextures")
        
        // set the animation duration
        let attackAnimation = SKAction.animate(with: demonAttackTextures, timePerFrame: 0.1)
        
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
        super.triggerAnimation(texture:demonHitTextures, key:"demonHitTextures")
        
        // set the animation duration
        let attackAnimation = SKAction.animate(with: demonHitTextures, timePerFrame: 0.1)
        
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
