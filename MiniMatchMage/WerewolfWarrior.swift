//
//  WerewolfWarrior.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-03-27.
//

import Foundation
import SpriteKit

class WerewolfWarrior: Enemy {
    
    private var werewolfWarriorAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "WerewolfWarrior")
    }
    
    private var werewolfWarriorTexture: SKTexture {
        return werewolfWarriorAtlas.textureNamed("WerewolfWarrior")
    }
    
    // add enemy idle animation into fairyAtlas
    private var werewolfWarriorIdleTextures: [SKTexture] {
        return [
            werewolfWarriorAtlas.textureNamed("werewolf warrior_idle_0"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_idle_1"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_idle_2"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_idle_3"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_idle_4"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_idle_5"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_idle_6"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_idle_7"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_idle_8")
        ]
    }
    
    // add enemy attack animation into fairyAtlas
    private var werewolfWarriorAttackTextures: [SKTexture] {
        return [
            werewolfWarriorAtlas.textureNamed("werewolf warrior_attack_0"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_attack_1"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_attack_2"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_attack_3"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_attack_4"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_attack_5"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_attack_6"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_attack_7"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_attack_8"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_attack_9")
        ]
    }
    
    private var werewolfWarriorHitTextures: [SKTexture] {
        return [
            werewolfWarriorAtlas.textureNamed("werewolf warrior_hit_0"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_hit_1"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_hit_2"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_hit_3"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_hit_4"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_hit_5"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_hit_6"),
            werewolfWarriorAtlas.textureNamed("werewolf warrior_hit_7")
        ]
    }
    
    // set up the fairy image
    func setupEnemy(width: CGFloat, height: CGFloat, pos: CGPoint) {
        // Use subclass-specific textures fairyTexture
        super.setup(texture: werewolfWarriorTexture, width: width, height: height, pos: pos)
    }
    
    // trigger enemy idle animation
    func startIdleAnimation() {
        super.triggerAnimation(texture:werewolfWarriorIdleTextures, key:"werewolfWarriorIdleTextures")
    }
    
    // trigger enemy attack animation
    func startAttackAnimation() {
        super.triggerAnimation(texture:werewolfWarriorAttackTextures, key:"werewolfWarriorAttackTextures")
    }
    
    // trigger animation when get hit
    func startHitAnimation() {
        super.triggerAnimation(texture:werewolfWarriorHitTextures, key:"werewolfWarriorHitTextures")
    }
}
