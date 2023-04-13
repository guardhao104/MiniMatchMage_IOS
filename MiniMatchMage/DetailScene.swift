//
//  DetailScene.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-04-11.
//

import Foundation
import SpriteKit

class DetailScene: SKScene {
    override func didMove(to view: SKView) {
        let labelNode = SKLabelNode(text: "Welcome to the new scene!")
        labelNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        labelNode.fontSize = 32
        labelNode.fontColor = .white
        self.addChild(labelNode)
    }
}
