//
//  BoardTile.swift
//  MiniMatchMage
//
//  Created by Harley on 2023-02-20.
//

import Foundation
import UIKit
import SceneKit

var geo1 = SCNScene(named: "Modules.scnassets/gem1.scn")!.rootNode.childNodes[0].geometry
var geo2 = SCNScene(named: "Modules.scnassets/gem2.scn")!.rootNode.childNodes[0].geometry
var geo3 = SCNScene(named: "Modules.scnassets/gem3.scn")!.rootNode.childNodes[0].geometry

struct BoardTile {
    var tileNo: Int = 0 {
        didSet {
            updateImage()
        }
    }
    var tileNode: SCNNode
    var imageView: UIImageView = UIImageView()
    
    func updateImage() {
//        imageView.image = UIImage(named: "tile\(tileNo)")
//        let scene = SCNScene(named: "Modules.scnassets/gem"+String(tileNo)+".scn")!
//        tileNode.geometry = scene.rootNode.childNodes[0].geometry
        switch tileNo {
        case 1:
            tileNode.geometry = geo1
        case 2:
            tileNode.geometry = geo2
        case 3:
            tileNode.geometry = geo3
        default:
            print("Tile ID out of range")
        }
    }
}
