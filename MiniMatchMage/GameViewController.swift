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
    
    var firstTileRow: Int = 0
    var firstTileColumn: Int = 0
    
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
            
            
            view.ignoresSiblingOrder = false
            
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
        enableTileInteraction()
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
    
    // Single match tile
    func singleMatch(_ row: Int, _ column: Int) {
        removeTile(row, column)
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
    }
    
    // Square match four tiles in square
    func squareMatch(_ column1: Int, _ column2: Int) {
        let tiles = [boardTiles[0][column1], boardTiles[0][column2], boardTiles[1][column1], boardTiles[1][column2]]
        if checkMatch(tiles) {
            removeTwoTiles(0, column1, column2)
            removeTwoTiles(1, column1, column2)
        }
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
        UIView.animate(withDuration: clearTileAnimateDuration) {
            currentTile.imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + clearTileAnimateDuration) {
            UIView.animate(withDuration: moveTileAnimateDuration) {
                for columnToMove in ((column + 1)..<numberOfColumns) {
                    let tile = self.boardTiles[row][columnToMove]
                    tile.imageView.frame.origin.x -= self.tileSize
                    self.boardTiles[row][columnToMove - 1] = tile
                }
                currentTile.imageView.frame.origin.x -= self.tileSize
                currentTile.tileNo = Int.random(in: tileNoRange)
            }
            currentTile.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            currentTile.imageView.frame.origin.x += CGFloat(numberOfColumns - column) * self.tileSize
            self.boardTiles[row][numberOfColumns - 1] = currentTile
        }
    }
    
    func removeTwoTiles(_ row: Int, _ column1: Int, _ column2: Int) {
        var currentTile1 = boardTiles[row][column1]
        var currentTile2 = boardTiles[row][column2]
        UIView.animate(withDuration: clearTileAnimateDuration) {
            currentTile1.imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
            currentTile2.imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + clearTileAnimateDuration) {
            UIView.animate(withDuration: moveTileAnimateDuration) {
                for columnToMove in ((column2 + 1)..<numberOfColumns) {
                    let tile = self.boardTiles[row][columnToMove]
                    tile.imageView.frame.origin.x -= self.tileSize * 2
                    self.boardTiles[row][columnToMove - 2] = tile
                }
                currentTile1.imageView.frame.origin.x -= self.tileSize * 2
                currentTile1.tileNo = Int.random(in: tileNoRange)
                currentTile2.imageView.frame.origin.x -= self.tileSize * 2
                currentTile2.tileNo = Int.random(in: tileNoRange)
            }
            currentTile1.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            currentTile2.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            currentTile1.imageView.frame.origin.x += CGFloat(numberOfColumns - column1) * self.tileSize
            currentTile2.imageView.frame.origin.x += CGFloat(numberOfColumns - column2 + 1) * self.tileSize
            self.boardTiles[row][numberOfColumns - 2] = currentTile1
            self.boardTiles[row][numberOfColumns - 1] = currentTile2
        }
    }
}
