//
//  GameViewController.swift
//  MiniMatchMage
//
//  Created by Harley on 2023-02-20.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var tileSize: Double = 0
    var boardTiles: [[BoardTile]] = []
    
    @IBOutlet weak var boardView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let boardWidth = Double(boardView.frame.width)
        tileSize = Double(boardWidth) / Double(numberOfColumns)
        createTilesBoard()
        updateTiles()
//        restart()
    }
    
    // Put tiles in board
    func createTilesBoard() {
        for row in 0..<numberOfRows {
            var newRow: [BoardTile] = []
            for column in 0..<numberOfColumns {
                let tileImageView = UIImageView(image: UIImage(named: "tile1"))
                tileImageView.frame = CGRect(x: Double(column) * tileSize, y: Double(row) * tileSize, width: tileSize, height: tileSize)
                boardView.addSubview(tileImageView)
                newRow += [BoardTile(tileNo: 1, imageView: tileImageView)]
            }
            boardTiles += [newRow]
        }
    }
    
    func updateTiles() {
        for row in 0..<numberOfRows {
            for column in 0..<numberOfColumns {
                let tileNo = Int.random(in: tileNoRange)
                boardTiles[row][column].tileNo = tileNo
            }
        }
    }
}
