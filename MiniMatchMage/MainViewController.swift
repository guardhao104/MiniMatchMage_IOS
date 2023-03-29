//
//  MainViewController.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-03-28.
//

import UIKit
import SpriteKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView(frame: self.view.bounds)
        myView.backgroundColor = UIColor.white
        self.view.addSubview(myView)
                
        let backgroundImageView = UIImageView(frame: myView.bounds)
        backgroundImageView.image = UIImage(named: "bg1.jpg")
        myView.addSubview(backgroundImageView)
                
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.setTitle("My Button", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
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
