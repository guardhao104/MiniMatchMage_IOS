//
//  CustomGLNode.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-04-12.
//

import SpriteKit
import GLKit

class CustomGLNode1: SKNode {
    private var eaglContext: EAGLContext?
    
    override init() {
        super.init()
        
        // Initialize OpenGL ES context
        eaglContext = EAGLContext(api: .openGLES3)
        
        // Set up the OpenGL ES rendering
        setupGL()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGL() {
        // Set up your OpenGL ES context, shaders, buffers, etc. here.
        // ...
        // Create the "Hello World" label with OpenGL ES
        let helloWorldLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        helloWorldLabel.text = "Hello World"
        helloWorldLabel.textColor = .white
        helloWorldLabel.font = UIFont.systemFont(ofSize: 30)
        helloWorldLabel.backgroundColor = .clear

        // Render the label to a texture
        let texture = SKTexture(image: labelToImage(label: helloWorldLabel))
        let sprite = SKSpriteNode(texture: texture)

        // Add the sprite to the CustomGLNode
        addChild(sprite)
    }

    private func labelToImage(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, UIScreen.main.scale)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
