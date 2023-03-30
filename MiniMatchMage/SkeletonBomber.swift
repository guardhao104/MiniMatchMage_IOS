//
//  SkeletonBomber.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-03-27.
//

import Foundation
import SpriteKit

class SkeletonBomber: Enemy {
    
    private var skeletonBomberAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "SkeletonBomber")
    }
    
    private var skeletonBomberTexture: SKTexture {
        return skeletonBomberAtlas.textureNamed("SkeletonBomber")
    }
    
    // add enemy idle animation into fairyAtlas
    private var skeletonBomberIdleTextures: [SKTexture] {
        return [
            skeletonBomberAtlas.textureNamed("skeletonBomber_idle_0"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_idle_1"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_idle_2"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_idle_3"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_idle_4"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_idle_5"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_idle_6"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_idle_7")
        ]
    }
    
    // add enemy attack animation into fairyAtlas
    private var skeletonBomberAttackTextures: [SKTexture] {
        return [
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_0"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_1"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_2"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_3"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_4"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_5"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_6"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_7"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_8"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_9"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_10"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_11"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_12"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_attack_13")
        ]
    }
    
    private var skeletonBomberHitTextures: [SKTexture] {
        return [
            skeletonBomberAtlas.textureNamed("skeletonBomber_hit_0"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_hit_1"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_hit_2"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_hit_3"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_hit_4"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_hit_5"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_hit_6"),
            skeletonBomberAtlas.textureNamed("skeletonBomber_hit_7")
        ]
    }
    
    // set up the fairy image
    func setupEnemy(width: CGFloat, height: CGFloat, pos: CGPoint) {
        // Use subclass-specific textures fairyTexture
        super.setup(texture: skeletonBomberTexture, width: width, height: height, pos: pos)
    }
    
    // trigger enemy idle animation
    func startIdleAnimation() {
        super.triggerAnimation(texture:skeletonBomberIdleTextures, key:"skeletonBomberIdleTextures")
    }
    
    // trigger enemy attack animation
    func startAttackAnimation() {
        super.triggerAnimation(texture:skeletonBomberAttackTextures, key:"skeletonBomberAttackTextures")
    }
    
    // trigger animation when get hit
    func startHitAnimation() {
        super.triggerAnimation(texture:skeletonBomberHitTextures, key:"skeletonBomberHitTextures")
    }
}
