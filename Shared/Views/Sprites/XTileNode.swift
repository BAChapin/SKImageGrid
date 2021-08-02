//
//  XTileNode.swift
//  XTileNode
//
//  Created by Brett Chapin on 8/1/21.
//

import SwiftUI
import SpriteKit

class XTileNode: SKSpriteNode {
    init?(gridSize: CGFloat) {
        guard let texture = XTileNode.drawX(gridSize: gridSize) else { return nil }
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    class func drawX(gridSize: CGFloat) -> SKTexture? {
        let size = CGSize(width: gridSize, height: gridSize)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: size.point.topRight)
        bezierPath.addLine(to: size.point.bottomLeft)
        bezierPath.move(to: size.point.topLeft)
        bezierPath.addLine(to: size.point.bottomRight)
        
        SKColor.red.setStroke()
        bezierPath.lineWidth = 5.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        
        return SKTexture(image: image)
    }
}
