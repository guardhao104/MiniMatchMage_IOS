//
//  GameViewController.swift
//  MiniMatchMage
//
//  Created by Harley on 2023-02-20.
//

import UIKit
import SpriteKit
import GameplayKit
import SceneKit

class GameViewController: UIViewController {
    var tileSize: Double = 0
    var boardTiles: [[BoardTile]] = []
    
    var firstTileRow: Int = 0
    var firstTileColumn: Int = 0
    
    @IBOutlet weak var boardView: SCNView!
    
    var scene: SCNScene = SCNScene(named: "Modules.scnassets/diamonds1.scn")!
    var gem1: SCNScene = SCNScene(named: "Modules.scnassets/gem1.scn")!
    var gem2: SCNScene = SCNScene(named: "Modules.scnassets/gem2.scn")!
    var gem3: SCNScene = SCNScene(named: "Modules.scnassets/gem3.scn")!
    
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
            
            view.ignoresSiblingOrder = false
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        boardView.scene = scene
        scene.background.contents = UIImage(named: "gem_bg.jpg")
        
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
        var enemysetting = getEnemy(levelofGame: 1)
        let boardWidth = Double(boardView.frame.width)
        tileSize = Double(boardWidth) / Double(numberOfColumns)
        createTilesBoard()
        updateTiles()
        enableTileInteraction()
//        restart()
    }
    
    // Put tiles in board
    func createTilesBoard() {
        for row in 0..<numberOfRows {
            var newRow: [BoardTile] = []
            for column in 0..<numberOfColumns {
                let geo = gem1.rootNode.childNodes[0].geometry
                let gemNode = SCNNode(geometry: geo)
                gemNode.position = SCNVector3(x: Float(column * 3 - 9), y: 0, z: Float(row * 3) - 1.5)
                scene.rootNode.addChildNode(gemNode)
                
                let tileImage = UIImageView(image: UIImage(named:"none"))
                tileImage.frame = CGRect(x: Double(column) * tileSize, y: Double(row) * tileSize, width: tileSize, height: tileSize)
                boardView.addSubview(tileImage)
                newRow += [BoardTile(tileNo: 1, tileNode: gemNode, imageView: tileImage)]
                
                
//                let tileImageView = UIImageView(image: UIImage(named: "tile1"))
//                tileImageView.frame = CGRect(x: Double(column) * tileSize, y: Double(row) * tileSize, width: tileSize, height: tileSize)
//                boardView.addSubview(tileImageView)
//                newRow += [BoardTile(tileNo: 1, imageView: tileImageView)]
            }
            boardTiles += [newRow]
        }
    }
    
    // Update random tiles
    func updateTiles() {
        for row in 0..<numberOfRows {
            for column in 0..<numberOfColumns {
                let tileNo = Int.random(in: tileNoRange)
                boardTiles[row][column].tileNo = tileNo
            }
        }
    }
    
    // Disable tiles' user interaction
    func disableTileInteraction() {
        for row in 0..<numberOfRows {
            for column in 0..<numberOfColumns {
                boardTiles[row][column].imageView.isUserInteractionEnabled = false
            }
        }
    }
    
    // Enable tiles' user interaction
    func enableTileInteraction() {
        for row in 0..<numberOfRows {
            for column in 0..<numberOfColumns {
                boardTiles[row][column].imageView.isUserInteractionEnabled = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        for (row, boardTilesRow) in boardTiles.enumerated() {
            for (column, currentTile) in boardTilesRow.enumerated() {
                if currentTile.imageView == touch.view {
                    firstTileRow = row
                    firstTileColumn = column
                }
            }
        }
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let pos = touch.location(in: self.boardView)
        let row = firstTileRow
        let column = firstTileColumn
        let closedRow = 1 - row
        if boardTiles[row][column].imageView.frame.contains(pos) {
            singleMatch(row, column)
        } else if boardTiles[closedRow][column].imageView.frame.contains(pos) {
            doubleMatch(row, closedRow, column, column)
        } else if column-1>=0 && boardTiles[row][column-1].imageView.frame.contains(pos) {
            doubleMatch(row, row, column-1, column)
        } else if column+1<=numberOfColumns-1 && boardTiles[row][column+1].imageView.frame.contains(pos) {
            doubleMatch(row, row, column, column+1)
        } else if column-1>=0 && boardTiles[closedRow][column-1].imageView.frame.contains(pos) {
            squareMatch(column-1, column)
        } else if column+1<=numberOfColumns-1 && boardTiles[closedRow][column+1].imageView.frame.contains(pos) {
            squareMatch(column, column+1)
        }
    }
    
    // cast(int id, int num){switch  cast}
    func playerAttack(_ tileId: Int, _ num: Int){
        switch tileId{
        case 1:
            castSpell("fire",num)
            print("castfire", num)
        case 2:
            castSpell("water",num)
            print("castwater",num)
        case 3:
            castSpell("wind",num)
            print("castwind",num)
        default:
            print("Invalid cast")
        }
        endEnemyTurn();
    }
    
    // Single match tile
    func singleMatch(_ row: Int, _ column: Int) {
        removeTile(row, column)
        playerAttack(boardTiles[row][column].tileNo,1)
        
    }
    
    // Double match tiles in line
    func doubleMatch(_ row1: Int, _ row2: Int, _ column1: Int, _ column2: Int) {
        let tiles = [boardTiles[row1][column1], boardTiles[row2][column2]]
        if checkMatch(tiles) {
            if row1 == row2 {
                removeTwoTiles(row1, column1, column2)
            } else {
                removeTile(row1, column1)
                removeTile(row2, column2)
            }
        }
        playerAttack(boardTiles[row1][column1].tileNo,2)
    }
    
    // Square match four tiles in square
    func squareMatch(_ column1: Int, _ column2: Int) {
        let tiles = [boardTiles[0][column1], boardTiles[0][column2], boardTiles[1][column1], boardTiles[1][column2]]
        if checkMatch(tiles) {
            removeTwoTiles(0, column1, column2)
            removeTwoTiles(1, column1, column2)
        }
        playerAttack(boardTiles[0][column1].tileNo,3)
    }
    
    func checkMatch(_ tiles: [BoardTile]) -> Bool {
        let tileNo = tiles.first?.tileNo
        var result: Bool = true
        for tile in tiles {
            if tile.tileNo != tileNo {
                result = false
                break
            }
        }
        return result
    }
    
    func removeTile(_ row: Int, _ column: Int) {
        var currentTile = boardTiles[row][column]
        
        let fadeOutAnimation = CABasicAnimation(keyPath: "scale")
        fadeOutAnimation.toValue = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
        fadeOutAnimation.duration = clearTileAnimateDuration
        
        currentTile.tileNode.addAnimation(fadeOutAnimation, forKey: "scale")
        
        UIView.animate(withDuration: clearTileAnimateDuration) {
            currentTile.imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + clearTileAnimateDuration) {
            UIView.animate(withDuration: moveTileAnimateDuration) {
                for columnToMove in ((column + 1)..<numberOfColumns) {
                    let tile = self.boardTiles[row][columnToMove]
                    let shiftLeftAnimation = CABasicAnimation(keyPath: "position.x")
                    shiftLeftAnimation.fromValue = tile.tileNode.position.x
                    shiftLeftAnimation.toValue = tile.tileNode.position.x - 3.0
                    shiftLeftAnimation.duration = moveTileAnimateDuration
                    tile.tileNode.addAnimation(shiftLeftAnimation, forKey: "shift")
                    tile.tileNode.position.x -= 3.0
                    tile.imageView.frame.origin.x -= self.tileSize
                    self.boardTiles[row][columnToMove - 1] = tile
                }
                currentTile.imageView.frame.origin.x -= self.tileSize
                currentTile.tileNo = Int.random(in: tileNoRange)
                let shiftLeftAnimation = CABasicAnimation(keyPath: "position.x")
                shiftLeftAnimation.fromValue = currentTile.tileNode.position.x
                shiftLeftAnimation.toValue = currentTile.tileNode.position.x - 3.0
                shiftLeftAnimation.duration = moveTileAnimateDuration
                currentTile.tileNode.addAnimation(shiftLeftAnimation, forKey: "shift")
                currentTile.tileNode.position.x -= 3.0
            }
            currentTile.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            currentTile.tileNode.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)
            currentTile.imageView.frame.origin.x += CGFloat(numberOfColumns - column) * self.tileSize
            currentTile.tileNode.position.x += Float(numberOfColumns - column) * 3
            self.boardTiles[row][numberOfColumns - 1] = currentTile
        }
    }
    
    func removeTwoTiles(_ row: Int, _ column1: Int, _ column2: Int) {
        var currentTile1 = boardTiles[row][column1]
        var currentTile2 = boardTiles[row][column2]
        
        let fadeOutAnimation = CABasicAnimation(keyPath: "scale")
        fadeOutAnimation.toValue = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
        fadeOutAnimation.duration = clearTileAnimateDuration
        
        currentTile1.tileNode.addAnimation(fadeOutAnimation, forKey: "scale")
        currentTile2.tileNode.addAnimation(fadeOutAnimation, forKey: "scale")
        
        UIView.animate(withDuration: clearTileAnimateDuration) {
            currentTile1.imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
            currentTile2.imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + clearTileAnimateDuration) {
            UIView.animate(withDuration: moveTileAnimateDuration) {
                for columnToMove in ((column2 + 1)..<numberOfColumns) {
                    let tile = self.boardTiles[row][columnToMove]
                    let shiftLeftAnimation = CABasicAnimation(keyPath: "position.x")
                    shiftLeftAnimation.fromValue = tile.tileNode.position.x
                    shiftLeftAnimation.toValue = tile.tileNode.position.x - 6.0
                    shiftLeftAnimation.duration = moveTileAnimateDuration
                    tile.tileNode.addAnimation(shiftLeftAnimation, forKey: "shift")
                    tile.tileNode.position.x -= 6.0
                    tile.imageView.frame.origin.x -= self.tileSize * 2
                    self.boardTiles[row][columnToMove - 2] = tile
                }
                var shiftLeftAnimation = CABasicAnimation(keyPath: "position.x")
                shiftLeftAnimation.fromValue = currentTile1.tileNode.position.x
                shiftLeftAnimation.toValue = currentTile1.tileNode.position.x - 6.0
                shiftLeftAnimation.duration = moveTileAnimateDuration
                currentTile1.tileNode.addAnimation(shiftLeftAnimation, forKey: "shift")
                currentTile1.tileNode.position.x -= 6.0
                currentTile1.imageView.frame.origin.x -= self.tileSize * 2
                currentTile1.tileNo = Int.random(in: tileNoRange)
                shiftLeftAnimation = CABasicAnimation(keyPath: "position.x")
                shiftLeftAnimation.fromValue = currentTile2.tileNode.position.x
                shiftLeftAnimation.toValue = currentTile2.tileNode.position.x - 6.0
                shiftLeftAnimation.duration = moveTileAnimateDuration
                currentTile2.tileNode.addAnimation(shiftLeftAnimation, forKey: "shift")
                currentTile2.tileNode.position.x -= 6.0
                currentTile2.imageView.frame.origin.x -= self.tileSize * 2
                currentTile2.tileNo = Int.random(in: tileNoRange)
            }
            currentTile1.tileNode.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)
            currentTile1.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            currentTile2.tileNode.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)
            currentTile2.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            currentTile1.tileNode.position.x += Float(numberOfColumns - column1) * 3
            currentTile1.imageView.frame.origin.x += CGFloat(numberOfColumns - column1) * self.tileSize
            currentTile2.tileNode.position.x += Float(numberOfColumns - column2 + 1) * 3
            currentTile2.imageView.frame.origin.x += CGFloat(numberOfColumns - column2 + 1) * self.tileSize
            self.boardTiles[row][numberOfColumns - 2] = currentTile1
            self.boardTiles[row][numberOfColumns - 1] = currentTile2
        }
    }
}
