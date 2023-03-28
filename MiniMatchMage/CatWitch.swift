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
    func startIdleAnimation() {
        super.triggerAnimation(texture:catWitchIdleTextures, key:"fairyIdleTextures")
    }
    
    // trigger enemy attack animation
    func startAttackAnimation() {
        super.triggerAnimation(texture:catWitchAttackTextures, key:"fairyAttackTextures")
    }
    
    // trigger animation when get hit
    func startHitAnimation() {
        super.triggerAnimation(texture:catWitchHitTextures, key:"fairyHitTextures")
    }
}
