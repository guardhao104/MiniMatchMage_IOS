//
//  GameScene.swift
//  MiniMatchMage
//
//  Created by Harley on 2023-02-20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var background = SKSpriteNode(imageNamed: "bg1.jpeg") // background image
    
    var player : SKSpriteNode!
    var enemy1 : SKSpriteNode!
    var enemy2 : SKSpriteNode!
    var enemy3 : SKSpriteNode!
    
    private var playerAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Player1Animation")
    }
    
    private var enemy1Atlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Enemy1Animation")
    }
    
    private var enemy2Atlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Enemy2Animation")
    }

    private var playerTexture: SKTexture {
        return playerAtlas.textureNamed("Player1Animation")
    }
    
    private var enemy1Texture: SKTexture {
        return enemy1Atlas.textureNamed("Enemy1Animation")
    }
    
    private var enemy2Texture: SKTexture {
        return enemy2Atlas.textureNamed("Enemy2Animation")
    }
    
    // add enemy attack animation into playerAtlas
    private var playerAttackTextures: [SKTexture] {
        return [
            playerAtlas.textureNamed("attack_1"),
            playerAtlas.textureNamed("attack_2"),
            playerAtlas.textureNamed("attack_3"),
            playerAtlas.textureNamed("attack_4"),
            playerAtlas.textureNamed("attack_5")
        ]
    }
    
    // add enemy idle animation into playerAtlas
    private var playerIdleTextures: [SKTexture] {
        return [
            playerAtlas.textureNamed("idle_1"),
            playerAtlas.textureNamed("idle_2"),
            playerAtlas.textureNamed("idle_3"),
            playerAtlas.textureNamed("idle_4")
        ]
    }
    
    // add enemy attack animation into ememy1Atlas
    private var enemy1AttackTextures: [SKTexture] {
        return [
            enemy1Atlas.textureNamed("enemy_1_attack_0"),
            enemy1Atlas.textureNamed("enemy_1_attack_1"),
            enemy1Atlas.textureNamed("enemy_1_attack_2"),
            enemy1Atlas.textureNamed("enemy_1_attack_3"),
            enemy1Atlas.textureNamed("enemy_1_attack_4"),
            enemy1Atlas.textureNamed("enemy_1_attack_5"),
            enemy1Atlas.textureNamed("enemy_1_attack_6"),
            enemy1Atlas.textureNamed("enemy_1_attack_7"),
            enemy1Atlas.textureNamed("enemy_1_attack_8"),
            enemy1Atlas.textureNamed("enemy_1_attack_9"),
            enemy1Atlas.textureNamed("enemy_1_attack_10")
        ]
    }
    
    // add enemy idle animation into ememy1Atlas
    private var enemy1IdleTextures: [SKTexture] {
        return [
            enemy1Atlas.textureNamed("enemy_1_idle_0"),
            enemy1Atlas.textureNamed("enemy_1_idle_1"),
            enemy1Atlas.textureNamed("enemy_1_idle_2"),
            enemy1Atlas.textureNamed("enemy_1_idle_3"),
            enemy1Atlas.textureNamed("enemy_1_idle_4"),
            enemy1Atlas.textureNamed("enemy_1_idle_5"),
            enemy1Atlas.textureNamed("enemy_1_idle_6"),
            enemy1Atlas.textureNamed("enemy_1_idle_7"),
            enemy1Atlas.textureNamed("enemy_1_idle_8")
        ]
    }
    
    private var enemy2AttackTextures: [SKTexture] {
        return [
            enemy2Atlas.textureNamed("enemy_2_attack_0"),
            enemy2Atlas.textureNamed("enemy_2_attack_1"),
            enemy2Atlas.textureNamed("enemy_2_attack_2"),
            enemy2Atlas.textureNamed("enemy_2_attack_3"),
            enemy2Atlas.textureNamed("enemy_2_attack_4"),
            enemy2Atlas.textureNamed("enemy_2_attack_5"),
            enemy2Atlas.textureNamed("enemy_2_attack_6"),
            enemy2Atlas.textureNamed("enemy_2_attack_7"),
            enemy2Atlas.textureNamed("enemy_2_attack_8"),
            enemy2Atlas.textureNamed("enemy_2_attack_9"),
            enemy2Atlas.textureNamed("enemy_2_attack_10")
        ]
    }
    
    private var enemy2IdleTextures: [SKTexture] {
        return [
            enemy2Atlas.textureNamed("enemy_2_idle_0"),
            enemy2Atlas.textureNamed("enemy_2_idle_1"),
            enemy2Atlas.textureNamed("enemy_2_idle_2"),
            enemy2Atlas.textureNamed("enemy_2_idle_3"),
            enemy2Atlas.textureNamed("enemy_2_idle_4"),
            enemy2Atlas.textureNamed("enemy_2_idle_5"),
            enemy2Atlas.textureNamed("enemy_2_idle_6")
        ]
    }
    
    // set up the player image
    private func setupPlayer() {
        // set the texture size
        player = SKSpriteNode(texture: playerTexture, size: CGSize(width: 350, height: 350))
        // set the texture position
        player.position = CGPoint(x: -250, y: 100)
        
        addChild(player)
    }
    
    // set up the enemy image
    private func setupEnemy1() {
        enemy1 = SKSpriteNode(texture: enemy1Texture, size: CGSize(width: 250, height: 250))
        enemy1.position = CGPoint(x: 120, y : 100)
        enemy2 = SKSpriteNode(texture: enemy2Texture, size: CGSize(width: 250, height: 250))
        enemy2.position = CGPoint(x: 200, y : 100)
//        enemy3 = SKSpriteNode(texture: enemy1Texture, size: CGSize(width: 250, height: 250))
//        enemy3.position = CGPoint(x: 280, y : 100)
        addChild(enemy1)
        addChild(enemy2)
//        addChild(enemy3)
    }
    
    // trigger player attack animation
    func startAttackAnimation() {
        // set the animation duration
        let attackAnimation = SKAction.animate(with: playerAttackTextures, timePerFrame: 0.1)

        // run the animation
//        player.run(SKAction.repeatForever(attackAnimation), withKey: "playerAttackTextures")
        
        player.run(attackAnimation, completion: {
            // When the animation is complete, start the idle animation
            self.startIdleAnimation()
        })
        
    }
    
    // trigger emeny1 frame attack animation
    func startEnemy1AttackAnimation() {

        let attackAnimation = SKAction.animate(with: enemy1AttackTextures, timePerFrame: 0.1)
           
        enemy1.run(SKAction.repeatForever(attackAnimation), withKey: "enemy1AttackTextures")
        
        
//        let attackAnimation = SKAction.animate(with: enemy1AttackTextures, timePerFrame: 0.1)
//
//        let attackSequence = SKAction.sequence([
//            SKAction.repeat(attackAnimation, count: 1),
//            SKAction.run {
//                self.enemy1.removeAction(forKey: "enemy1AttackTextures")
//                self.startEnemy1IdleAnimation()
//            }
//        ])
//
//        enemy1.run(attackSequence, withKey: "enemy1AttackTextures")
    }
    
//    // trigger emeny2 frame attack animation
//    func startEnemy2AttackAnimation() {
//        let attackAnimation = SKAction.animate(with: enemy2AttackTextures, timePerFrame: 0.1)
//
//        enemy2.run(attackAnimation, completion: {
//            // When the animation is complete, start the idle animation
//            self.startIdleAnimation()
//        })
//    }
//
//    // trigger emeny3 frame attack animation
//    func startEnemy3AttackAnimation() {
//        let attackAnimation = SKAction.animate(with: enemy1AttackTextures, timePerFrame: 0.1)
//
//        enemy3.run(attackAnimation, completion: {
//            // When the animation is complete, start the idle animation
//            self.startIdleAnimation()
//        })
//    }

    // trigger player idle animation
    func startIdleAnimation() {
        // set the animation duration
        let idleAnimation = SKAction.animate(with: playerIdleTextures, timePerFrame: 0.1)

        // run the animation
        player.run(SKAction.repeatForever(idleAnimation), withKey: "playerIdleTextures")
    }
    
    // trigger enemy idle animation
    func startEnemy1IdleAnimation() {
        let idleAnimation = SKAction.animate(with: enemy1IdleTextures, timePerFrame: 0.1)
        let idleAnimation2 = SKAction.animate(with: enemy2IdleTextures, timePerFrame: 0.1)
        
        enemy1.run(SKAction.repeatForever(idleAnimation), withKey: "enemy1IdleTextures")
        enemy2.run(SKAction.repeatForever(idleAnimation2), withKey: "enemy2IdleTextures")
//        enemy3.run(SKAction.repeatForever(idleAnimation), withKey: "enemy1IdleTextures")
    }
    
    // set background image onto screen
    func setBackgroundImage() {
        background.position = CGPoint(x: 0, y: 260)
        background.size.width = self.size.width
        background.size.height = self.size.height
        background.anchorPoint = CGPoint(x: 0.5,y: 0.5)

        self.addChild(background)
    }
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        setBackgroundImage();
        
        self.setupPlayer()
        self.startIdleAnimation()
//        self.startAttackAnimation()
        self.setupEnemy1()
        self.startEnemy1IdleAnimation()
//        self.startEnemy1AttackAnimation()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        for touch in touches {
            let location = touch.location(in: self)
            if enemy1.contains(location) {
                startEnemy1AttackAnimation()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
