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
            doubleMatch(row, row, column, column-1)
        } else if column+1<=numberOfColumns-1 && boardTiles[row][column+1].imageView.frame.contains(pos) {
            doubleMatch(row, row, column, column+1)
        } else if column-1>=0 && boardTiles[closedRow][column-1].imageView.frame.contains(pos) {
            squareMatch(column, column-1)
        } else if column+1<=numberOfColumns-1 && boardTiles[closedRow][column+1].imageView.frame.contains(pos) {
            squareMatch(column, column+1)
        }
    }
    
    func doubleMatch(_ row1: Int, _ row2: Int, _ column1: Int, _ column2: Int) {
        print("Double")
    }
    
    func squareMatch(_ column1: Int, _ column2: Int) {
        print("Square")
    }
    
    func singleMatch(_ row: Int, _ column: Int) {
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
}
