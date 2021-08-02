//
//  PathTile.swift
//  PathTile
//
//  Created by Brett Chapin on 8/1/21.
//

import SwiftUI
import SpriteKit

class PathTile: SKSpriteNode {
    init?(gridSize: CGFloat) {
        guard let texture = PathTile.drawTile(gridSize: gridSize) else { return nil }
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func drawTile(gridSize: CGFloat) -> SKTexture? {
        let size = CGSize(width: gridSize, height: gridSize)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: size.point.topLeft)
        bezierPath.addLine(to: size.point.topRight)
        bezierPath.addLine(to: size.point.bottomRight)
        bezierPath.addLine(to: size.point.bottomLeft)
        bezierPath.addLine(to: size.point.topLeft)
        
        SKColor.green.withAlphaComponent(0.3).setFill()
        bezierPath.fill()
        context.addPath(bezierPath.cgPath)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        
        return SKTexture(image: image)
    }
}
