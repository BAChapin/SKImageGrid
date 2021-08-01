//
//  ImageNode.swift
//  ImageNode
//
//  Created by Brett Chapin on 8/1/21.
//

import SwiftUI
import SpriteKit

class ImageNode: SKSpriteNode {
    convenience init(image: UIImage, nodeName name: String) {
        let texture = SKTexture(image: image)
        self.init(texture: texture)
        self.name = name
    }
}
