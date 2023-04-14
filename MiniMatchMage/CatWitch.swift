//
//  CatWitch.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-03-27.
//

import Foundation
import SpriteKit

class CatWitch: Enemy {
    
    private var catWitchAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "CatWitch")
    }
    
    private var catWitchTexture: SKTexture {
        return catWitchAtlas.textureNamed("CatWitch")
    }
    
    // add enemy idle animation into fairyAtlas
    private var catWitchIdleTextures: [SKTexture] {
        return [
            catWitchAtlas.textureNamed("enemy_2_idle_0"),
            catWitchAtlas.textureNamed("enemy_2_idle_1"),
            catWitchAtlas.textureNamed("enemy_2_idle_2"),
            catWitchAtlas.textureNamed("enemy_2_idle_3"),
            catWitchAtlas.textureNamed("enemy_2_idle_4"),
            catWitchAtlas.textureNamed("enemy_2_idle_5"),
            catWitchAtlas.textureNamed("enemy_2_idle_6")
        ]
    }
    
    // add enemy attack animation into fairyAtlas
    private var catWitchAttackTextures: [SKTexture] {
        return [
            catWitchAtlas.textureNamed("enemy_2_attack_0"),
            catWitchAtlas.textureNamed("enemy_2_attack_1"),
            catWitchAtlas.textureNamed("enemy_2_attack_2"),
            catWitchAtlas.textureNamed("enemy_2_attack_3"),
            catWitchAtlas.textureNamed("enemy_2_attack_4"),
            catWitchAtlas.textureNamed("enemy_2_attack_5"),
            catWitchAtlas.textureNamed("enemy_2_attack_6"),
            catWitchAtlas.textureNamed("enemy_2_attack_7"),
            catWitchAtlas.textureNamed("enemy_2_attack_8"),
            catWitchAtlas.textureNamed("enemy_2_attack_9"),
            catWitchAtlas.textureNamed("enemy_2_attack_10")
        ]
    }
    
    private var catWitchHitTextures: [SKTexture] {
        return [
            catWitchAtlas.textureNamed("enemy_2_hit_0"),
            catWitchAtlas.textureNamed("enemy_2_hit_1"),
            catWitchAtlas.textureNamed("enemy_2_hit_2"),
            catWitchAtlas.textureNamed("enemy_2_hit_3"),
            catWitchAtlas.textureNamed("enemy_2_hit_4"),
            catWitchAtlas.textureNamed("enemy_2_hit_5"),
            catWitchAtlas.textureNamed("enemy_2_hit_6"),
            catWitchAtlas.textureNamed("enemy_2_hit_7")
        ]
    }
    
    // set up the fairy image
    func setupEnemy(width: CGFloat, height: CGFloat, pos: CGPoint) {
        // Use subclass-specific textures fairyTexture
        super.setup(texture: catWitchTexture, width: width, height: height, pos: pos)
    }
    
    // trigger enemy idle animation
    override func startIdleAnimation() {
        super.triggerAnimation(texture:catWitchIdleTextures, key:"catWitchIdleTextures")
    }
    
    // trigger enemy attack animation
    override func startAttackAnimation() {
        super.triggerAnimation(texture:catWitchAttackTextures, key:"catWitchAttackTextures")
        
        // set the animation duration
        let attackAnimation = SKAction.animate(with: catWitchAttackTextures, timePerFrame: 0.1)
        
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
        super.triggerAnimation(texture:catWitchHitTextures, key:"catWitchHitTextures")
        
        // set the animation duration
        let attackAnimation = SKAction.animate(with: catWitchHitTextures, timePerFrame: 0.1)
        
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
