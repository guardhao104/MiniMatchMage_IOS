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
    var button = UIButton()
    
    static var record: Int = 0
    
    override func didMove(to view: SKView) {
        
        let buttonContainerView = UIView(frame: CGRect(x: size.width/2 - 100, y: size.height/2 - 25, width: 200, height: 50))
        buttonContainerView.backgroundColor = .clear
        view.addSubview(buttonContainerView)
        
        // create the button and add it to the container view
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.setTitle("ReStar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        buttonContainerView.addSubview(button)
        
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
        
        if(DetailScene.record < score)
        {
            DetailScene.record = score
        }
        
        numberLabel.text = "Score: " + String(score) + " The Highest Score: " + String(DetailScene.record)
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
        
        defaultPlayer.health = defaultPlayer.maxhealth
        defaultPlayer.shield = 0
        
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
    
    @objc func buttonPressed() {
        if let view = self.view {
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = self.scaleMode
            let transition = SKTransition.fade(withDuration: 1.0)
            view.presentScene(gameScene, transition: transition)
        }
        if let gameViewController = self.view?.window?.rootViewController as? GameViewController {
            gameViewController.boardView.isHidden = false
        }
        var enemysetting = getEnemy(levelofGame: 1)
        button.removeFromSuperview()
        print("run")
    }
}
