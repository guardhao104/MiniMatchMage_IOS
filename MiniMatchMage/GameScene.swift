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
    
    var player : SKSpriteNode!
    var enemy1 : SKSpriteNode!
    
    private var playerAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "Player1Animation")
    }
    
//    private var enemy1Atlas: SKTextureAtlas {
//        return SKTextureAtlas
//    }

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
        
        addChild(player)
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
        
        self.setupPlayerIdle()
        self.startAttackAnimation()
//        self.startIdleAnimation()
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
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
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
