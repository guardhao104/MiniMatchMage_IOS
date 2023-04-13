//
//  GameScene.swift
//  MiniMatchMage
//
//  Created by Harley on 2023-02-20.
//

import SpriteKit
import GameplayKit
import AVFoundation
import UIKit

var audioPlayer = AVAudioPlayer()

// mage global variable
var mageObj = Mage()
// enemy global variable
var enemyArr: [Enemy] = []

class GameScene: SKScene {
    
    var boardView: SCNView!
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
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    
    let image = UIImage(named: "turnCounter")
    private var flag:Bool = false
    
    // create SKCropNode object
    let cropNode = SKCropNode()

    // create a background spriteNode as background
    let backgroundNode = SKSpriteNode(color: .lightGray, size: CGSize(width: 100, height: 20))
    // create a front spriteNode as progress bar
    let progressNode = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 20))
    
    // create SKCropNode object
    let cropNd1 = SKCropNode()
    // create a background spriteNode as background
    let backgroundNd1 = SKSpriteNode(color: .lightGray, size: CGSize(width: 100, height: 20))
    // create a front spriteNode as progress bar
    let progressNd1 = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 20))
    
    // create SKCropNode object
    let cropNd2 = SKCropNode()
    // create a background spriteNode as background
    let backgroundNd2 = SKSpriteNode(color: .lightGray, size: CGSize(width: 100, height: 20))
    // create a front spriteNode as progress bar
    let progressNd2 = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 20))
    
    // create SKCropNode object
    let playerCropNd = SKCropNode()
    // create a background spriteNode as background
    let playerBackgroundNd = SKSpriteNode(color: .lightGray, size: CGSize(width: 100, height: 20))
    // create a front spriteNode as progress bar
    let playerProgressNd = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 20))
    
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
        werewolfWarrior.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 100, y: 100))
        enemyArr.append(werewolfWarrior)
        addChild(werewolfWarrior)
        werewolfWarrior.startIdleAnimation()
        skeletonBomber1.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 250, y: 100))
        enemyArr.append(skeletonBomber1)
        addChild(skeletonBomber1)
        skeletonBomber1.startIdleAnimation()
        fairy2.setupEnemy(width: 250, height: 250, pos: CGPoint(x: 400, y: 100))
        enemyArr.append(fairy2)
        addChild(fairy2)
        fairy2.startIdleAnimation()
        
        addHPBar(cropNode: cropNd1, backgroundNode: backgroundNd1, progressNode: progressNd1, posX: 140, posY: -20)

        cropNode.maskNode = backgroundNode
        cropNode.addChild(progressNode)
        addChild(cropNode)
        let progress: CGFloat = 1
        progressNode.size.width = backgroundNode.size.width * progress
        cropNode.position = CGPoint(x:290, y:-20)
        
        cropNd2.maskNode = backgroundNd2
        cropNd2.addChild(progressNd2)
        addChild(cropNd2)
        let progress2: CGFloat = 1
        progressNd2.size.width = backgroundNd2.size.width * progress2
        cropNd2.position = CGPoint(x:450, y:-20)
        
        playerCropNd.maskNode = playerBackgroundNd
        playerCropNd.addChild(playerProgressNd)
        addChild(playerCropNd)
        let playerProgress: CGFloat = 1
        playerProgressNd.size.width = playerBackgroundNd.size.width * playerProgress
        playerCropNd.position = CGPoint(x:-240, y:-20)
        
        let buttonContainerView = UIView(frame: CGRect(x: size.width/2 - 100, y: size.height/2 - 25, width: 200, height: 50))
        buttonContainerView.backgroundColor = .clear
        view.addSubview(buttonContainerView)
        
        // create the button and add it to the container view
        button1.frame = CGRect(x: -40, y: -290, width: 50, height: 50)
        button1.setTitle("1", for: .normal)
        button1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button1.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button1.backgroundColor = .white
        button1.setTitleColor(.black, for: .normal)
        button1.setBackgroundImage(image, for: .normal)
        buttonContainerView.addSubview(button1)
        
        let buttonContainerView2 = UIView(frame: CGRect(x: size.width/2 - 100, y: size.height/2 - 25, width: 200, height: 50))
        buttonContainerView2.backgroundColor = .clear
        view.addSubview(buttonContainerView2)
       
        // create the button and add it to the container view
        button2.frame = CGRect(x: 70, y: -290, width: 50, height: 50)
        button2.setTitle("2", for: .normal)
        button2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button2.backgroundColor = .white
        button2.setTitleColor(.black, for: .normal)
        button2.setBackgroundImage(image, for: .normal)
        buttonContainerView.addSubview(button2)
       
        let buttonContainerView3 = UIView(frame: CGRect(x: size.width/2 - 100, y: size.height/2 - 25, width: 200, height: 50))
        buttonContainerView3.backgroundColor = .clear
        view.addSubview(buttonContainerView3)
       
        // create the button and add it to the container view
        button3.frame = CGRect(x: 180, y: -290, width: 50, height: 50)
        button3.setTitle("3", for: .normal)
        button3.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button3.backgroundColor = .white
        button3.setTitleColor(.black, for: .normal)
        button3.setBackgroundImage(image, for: .normal)
        buttonContainerView.addSubview(button3)
        
        
        // play bgm
        let sound = Bundle.main.path(forResource: "HesitantBlade", ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }

        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    // switch scene to DetailScene mainwhile stop bgm and remove all btns
    @objc func switchToDetailScene() {
        audioPlayer.stop()
        if let view = self.view {
            let detailScene = DetailScene(size: self.size)
            detailScene.scaleMode = self.scaleMode
            let transition = SKTransition.fade(withDuration: 1.0)
            view.presentScene(detailScene, transition: transition)
            button1.removeFromSuperview()
            button2.removeFromSuperview()
            button3.removeFromSuperview()
        }
    }
    
    @objc func buttonPressed() {
        var enemy1 = enemyList[0]
        print(enemy1)
    }
    
    @objc func buttonTapped() {
        print("Button Tapped")
    }

    func addHPBar(cropNode:SKCropNode, backgroundNode:SKSpriteNode, progressNode:SKSpriteNode, posX:CGFloat, posY:CGFloat) {
        cropNode.maskNode = backgroundNode
        cropNode.addChild(progressNode)
        addChild(cropNode)
        // Set the progress value of a progress bar
        let progress: CGFloat = 1
        progressNode.size.width = backgroundNode.size.width * progress

        // Set hp bar position
        cropNode.position = CGPoint(x:140, y:-20)
    }
    
    func setHPBarValue(val:CGFloat, backgroundNode:SKSpriteNode, progressNode:SKSpriteNode) {
        let progress: CGFloat = val
        progressNode.size.width = backgroundNode.size.width * progress
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
        if(defaultPlayer.health > 0)
        {
            var maxHp = defaultPlayer.maxhealth as! Int
            var hp = defaultPlayer.health as! Int
            var ratio = CGFloat(Float(hp) / Float(maxHp))
            setHPBarValue(val:ratio, backgroundNode : playerBackgroundNd, progressNode: playerProgressNd)
        }
        
        if(enemyList.count == 3)
        {
            var maxHp = enemyList[0]["maxHealth"] as! Int
            var hp = enemyList[0]["health"] as! Int
            var ratio = CGFloat(Float(hp) / Float(maxHp))
            setHPBarValue(val:ratio, backgroundNode : backgroundNd1, progressNode: progressNd1)
           
            maxHp = enemyList[1]["maxHealth"] as! Int
            hp = enemyList[1]["health"] as! Int
            ratio = CGFloat(Float(hp) / Float(maxHp))
            setHPBarValue(val:ratio, backgroundNode : backgroundNode, progressNode: progressNode)
            
            maxHp = enemyList[2]["maxHealth"] as! Int
            hp = enemyList[2]["health"] as! Int
            ratio = CGFloat(Float(hp) / Float(maxHp))
            setHPBarValue(val:ratio, backgroundNode : backgroundNd2, progressNode: progressNd2)
            
            var speed = enemyList[0]["speed"] as! Int
            var str = String(speed)
            button1.setTitle(str, for: .normal)
            
            speed = enemyList[1]["speed"] as! Int
            str = String(speed)
            button2.setTitle(str, for: .normal)
            
            speed = enemyList[2]["speed"] as! Int
            str = String(speed)
            button3.setTitle(str, for: .normal)
        }
        
        if(enemyList.count == 2)
        {
            setHPBarValue(val: 0.0, backgroundNode: backgroundNd1, progressNode: progressNd1)
            
            var maxHp = enemyList[0]["maxHealth"] as! Int
            var hp = enemyList[0]["health"] as! Int
            var ratio = CGFloat(Float(hp) / Float(maxHp))
            setHPBarValue(val:ratio, backgroundNode : backgroundNode, progressNode: progressNode)
           
            maxHp = enemyList[1]["maxHealth"] as! Int
            hp = enemyList[1]["health"] as! Int
            ratio = CGFloat(Float(hp) / Float(maxHp))
            setHPBarValue(val:ratio, backgroundNode : backgroundNd2, progressNode: progressNd2)
            
            button1.setTitle("X", for: .normal)
            
            var speed = enemyList[0]["speed"] as! Int
            var str = String(speed)
            button2.setTitle(str, for: .normal)
            
            speed = enemyList[1]["speed"] as! Int
            str = String(speed)
            button3.setTitle(str, for: .normal)
        }
        
        if(enemyList.count == 1)
        {
            setHPBarValue(val:0.0, backgroundNode : backgroundNode, progressNode: progressNode)
            
            var maxHp = enemyList[0]["maxHealth"] as! Int
            var hp = enemyList[0]["health"] as! Int
            var ratio = CGFloat(Float(hp) / Float(maxHp))
            setHPBarValue(val:ratio, backgroundNode : backgroundNd2, progressNode: progressNd2)
            
            button2.setTitle("X", for: .normal)
            
            var speed = enemyList[0]["speed"] as! Int
            var str = String(speed)
            button3.setTitle(str, for: .normal)
            flag = true
        }
        
        if (enemyList.count == 0 && flag == true)
        {
            setHPBarValue(val:0.0, backgroundNode : backgroundNd2, progressNode: progressNd2)
            button3.setTitle("X", for: .normal)
            switchToDetailScene();
        }
    }
}
