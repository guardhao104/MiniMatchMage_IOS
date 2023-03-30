//
//  MainViewController.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-03-28.
//

import UIKit
import SpriteKit

class MainViewController: UIViewController {
    let image = UIImage(named: "myImage")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView(frame: self.view.bounds)
        myView.backgroundColor = UIColor.white
        self.view.addSubview(myView)
                
        let image = UIImage(named: "button")
        
        let backgroundImageView = UIImageView(frame: myView.bounds)
        backgroundImageView.image = UIImage(named: "bg4.jpg")
        myView.addSubview(backgroundImageView)
                
        let button = UIButton(type: .system)
        button.frame = CGRect(x: (self.view.bounds.width - 250)/2, y: 250, width: 250, height:100)
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(image, for: .normal)
        myView.addSubview(button)

    }
    
    @objc func buttonPressed() {
        if let scene = GameScene(fileNamed: "GameScene") {
            scene.scaleMode = .aspectFill
            let gameViewController = UIViewController()
            gameViewController.view = SKView(frame: self.view.bounds)
            (gameViewController.view as! SKView).presentScene(scene)
            self.present(gameViewController, animated: true, completion: nil)
        }
    }

}
