//
//  BoardTile.swift
//  MiniMatchMage
//
//  Created by Harley on 2023-02-20.
//

import Foundation
import UIKit

struct BoardTile {
    var tileNo: Int = 0 {
        didSet {
            updateImage()
        }
    }
    
    var imageView: UIImageView = UIImageView()
    
    func updateImage() {
        imageView.image = UIImage(named: "tile\(tileNo)")
    }
}
