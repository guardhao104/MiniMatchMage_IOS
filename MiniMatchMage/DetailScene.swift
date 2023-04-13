//
//  DetailScene.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-04-11.
//

import SpriteKit

class DetailScene: SKScene, SKPhysicsContactDelegate {
    
    var numberLabel = SKLabelNode(fontNamed: "Helvetica")
    var dx: CGFloat = 0
    var dy: CGFloat = 0
    
    override func didMove(to view: SKView) {
        
        if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
            gameViewController.boardView.isHidden = true
        }

        self.backgroundColor = SKColor.white
        self.backgroundColor = SKColor.clear
        
        // set collider board
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame.insetBy(dx: -50, dy: -50))
        self.physicsBody = borderBody
        self.physicsBody?.friction = 0
        
        // set number
        let score = defaultPlayer.health;
        numberLabel.text = "Your Score: " + String(score)
        numberLabel.fontSize = 40
        numberLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(numberLabel)
        
        // set moving direction
        let randomAngle = CGFloat.random(in: 0..<CGFloat.pi*2)
        dx = cos(randomAngle) * 5
        dy = sin(randomAngle) * 5
        
        // set physicsBody
        let numberBody = SKPhysicsBody(rectangleOf: numberLabel.frame.size)
        numberBody.affectedByGravity = false
        numberBody.categoryBitMask = 1
        numberBody.contactTestBitMask = 1
        numberBody.collisionBitMask = 1
        numberLabel.physicsBody = numberBody
        
        self.physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        // update text position
        numberLabel.position = CGPoint(x: numberLabel.position.x + dx, y: numberLabel.position.y + dy)
        
        // check board
        if numberLabel.position.x < self.frame.minX + 50 || numberLabel.position.x > self.frame.maxX - 50 {
            dx = -dx
            self.backgroundColor = SKColor.clear

        }
        if numberLabel.position.y < self.frame.minY + 50 || numberLabel.position.y > self.frame.maxY - 50 {
            dy = -dy
            self.backgroundColor = SKColor.clear

        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // check collider
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 1 {
            dx = -dx
            dy = -dy
            self.backgroundColor = SKColor.red
        }
    }
}
