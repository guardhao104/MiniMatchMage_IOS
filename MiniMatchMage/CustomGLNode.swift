//
//  CustomGLNode.swift
//  MiniMatchMage
//
//  Created by yushuo lu on 2023-04-12.
//

import SpriteKit
import GLKit

class CustomGLNode: SKNode {
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

        // Create a custom SKSpriteNode
        let customSpriteNode = SKSpriteNode()

        // Set up a custom vertex shader
        let vertexShader = """
        attribute vec4 a_position;
        attribute vec2 a_texCoord;
        varying vec2 v_texCoord;
        uniform mat4 u_modelViewProjectionMatrix;
        
        void main() {
            v_texCoord = a_texCoord;
            gl_Position = u_modelViewProjectionMatrix * a_position;
        }
        """

        // Set up a custom fragment shader
        let fragmentShader = """
        precision mediump float;
        varying vec2 v_texCoord;
        uniform sampler2D u_texture;
        
        void main() {
            gl_FragColor = texture2D(u_texture, v_texCoord);
        }
        """

        // Create the shader program
        let shaderProgram = SKShader(source: vertexShader + fragmentShader)

        // Create the "Hello World" label
        let helloWorldLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        helloWorldLabel.text = "Hello Worlddal!!!"
        helloWorldLabel.textColor = .white
        helloWorldLabel.font = UIFont.systemFont(ofSize: 30)
        helloWorldLabel.backgroundColor = .clear

        // Render the label to a texture
        let texture = SKTexture(image: labelToImage(label: helloWorldLabel))

        // Apply the custom shader program to the custom sprite node
        customSpriteNode.texture = texture
        customSpriteNode.shader = shaderProgram
        customSpriteNode.size = CGSize(width: 300, height: 50)

        // Add the custom sprite node to the CustomGLNode
        addChild(customSpriteNode)
    }

    private func labelToImage(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false,
       UIScreen.main.scale)
       label.layer.render(in: UIGraphicsGetCurrentContext()!)
       let image = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return image!
   }
}
