//
//  GameScene.swift
//  MiniMatchMage
//
//  Created by Harley on 2023-02-20.
//

import SpriteKit
import GameplayKit

// mage global variable
var mageObj = Mage()
// enemy global variable
var enemyArr: [Enemy] = []

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var background = SKSpriteNode(imageNamed: "bg1.jpeg") // background image
    private let mage = Mage()
    private let fairy = Fairy()
    private let fairy1 = Fairy()
    private let fairy2 = Fairy()
    private let catWitch = CatWitch()
    private let catWitch1 = CatWitch()
    private let catWitch2 = CatWitch()
    private let demon = Demon()
    private let demon1 = Demon()
    private let demon2 = Demon()
    private let skeletonBomber = SkeletonBomber()
    private let skeletonBomber1 = SkeletonBomber()
    private let skeletonBomber2 = SkeletonBomber()
    private let werewolfWarrior = WerewolfWarrior()
    private let werewolfWarrior1 = WerewolfWarrior()
    private let werewolfWarrior2 = WerewolfWarrior()
    
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
        
        // setup the background image
        setBackgroundImage();
        
        // setup the player with idle animation
        mage.setup(size:CGSize(width: 350, height: 350), pos: CGPoint(x: -250, y: 100))
        mageObj = mage
        addChild(mage)
        mage.startPlayerIdleAnimation()

        // setup the enemies with idle animation
        werewolfWarrior.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 120, y: 100))
        enemyArr.append(werewolfWarrior)
        addChild(werewolfWarrior)
        werewolfWarrior.startIdleAnimation()
        skeletonBomber1.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 200, y: 100))
        enemyArr.append(skeletonBomber1)
        addChild(skeletonBomber1)
        skeletonBomber1.startIdleAnimation()
        fairy2.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 280, y: 100))
        enemyArr.append(fairy2)
        addChild(fairy2)
        fairy2.startIdleAnimation()
        
        
        
//        fairy.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 120, y: 100))
//        fairy1.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 200, y: 100))
//        fairy2.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 280, y: 100))
//
//        enemyArr.append(fairy)
//        enemyArr.append(fairy1)
//        enemyArr.append(fairy2)
//
//        addChild(fairy)
//        addChild(fairy1)
//        addChild(fairy2)
//
//        fairy.startIdleAnimation()
//        fairy1.startIdleAnimation()
//        fairy2.startIdleAnimation()
        
        
        
//        catWitch.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 120, y: 100))
//        catWitch1.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 200, y: 100))
//        catWitch2.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 280, y: 100))
//
//        enemyArr.append(catWitch)
//        enemyArr.append(catWitch1)
//        enemyArr.append(catWitch2)
//
//        addChild(catWitch)
//        addChild(catWitch1)
//        addChild(catWitch2)
//
//        catWitch.startIdleAnimation()
//        catWitch1.startIdleAnimation()
//        catWitch2.startIdleAnimation()
        
        
        
//        demon.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 120, y: 100))
//        demon1.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 200, y: 100))
//        demon2.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 280, y: 100))
//
//        enemyArr.append(demon)
//        enemyArr.append(demon1)
//        enemyArr.append(demon2)
//
//        addChild(demon)
//        addChild(demon1)
//        addChild(demon2)
//
//        demon.startIdleAnimation()
//        demon1.startIdleAnimation()
//        demon2.startIdleAnimation()
        
        
        
//        skeletonBomber.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 120, y: 100))
//        skeletonBomber1.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 200, y: 100))
//        skeletonBomber2.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 280, y: 100))
//
//        enemyArr.append(skeletonBomber)
//        enemyArr.append(skeletonBomber1)
//        enemyArr.append(skeletonBomber2)
//
//        addChild(skeletonBomber)
//        addChild(skeletonBomber1)
//        addChild(skeletonBomber2)
//
//        skeletonBomber.startIdleAnimation()
//        skeletonBomber1.startIdleAnimation()
//        skeletonBomber1.startIdleAnimation()
        
        
        
//        werewolfWarrior.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 120, y: 100))
//        werewolfWarrior1.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 200, y: 100))
//        werewolfWarrior2.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 280, y: 100))
//
//        enemyArr.append(werewolfWarrior)
//        enemyArr.append(werewolfWarrior1)
//        enemyArr.append(werewolfWarrior2)
//
//        addChild(werewolfWarrior)
//        addChild(werewolfWarrior1)
//        addChild(werewolfWarrior2)
//
//        werewolfWarrior.startIdleAnimation()
//        werewolfWarrior1.startAttackAnimation()
//        werewolfWarrior2.startHitAnimation()
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
        
//        for touch in touches {
//            let location = touch.location(in: self)
//            if enemy1.contains(location) {
//                startEnemy1AttackAnimation()
//            }
//        }
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
