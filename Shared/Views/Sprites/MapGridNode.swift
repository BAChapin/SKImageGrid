//
//  MapGrideNode.swift
//  MapGrideNode
//
//  Created by Brett Chapin on 8/1/21.
//

import SwiftUI
import SpriteKit

class MapGridNode: SKSpriteNode {
    var rows: Int!
    var columns: Int!
    var gridSize: CGFloat
    
    init?(gridSize: CGFloat, imageSize: CGSize) {
        let newSize = imageSize.add(width: 50.0, height: 50.0)
        self.gridSize = gridSize
        self.columns = Int(newSize.width / gridSize)
        self.rows = Int(newSize.height / gridSize)
        guard let texture = MapGridNode.gridTexture(gridSize: gridSize, rows: rows, columns: columns, contextSize: newSize) else { return nil }
        super.init(texture: texture, color: .clear, size: texture.size())
        self.name = "MapGrid"
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.gridSize = 0.0
        super.init(coder: aDecoder)
    }
    
    class func gridTexture(gridSize: CGFloat, rows: Int, columns: Int, contextSize: CGSize) -> SKTexture? {
        let size = CGSize(width: CGFloat(columns) * gridSize + 1, height: CGFloat(rows) * gridSize + 1)
        UIGraphicsBeginImageContext(contextSize)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let bezierPath = UIBezierPath()
        let offset: CGFloat = 0.5
        
        // Draw Horizontal Row Lines
        for i in 0...rows {
            let y = CGFloat(i) * gridSize + offset
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: size.width, y: y))
        }
        
        // Draw Vertical Column Lines
        for i in 0...columns {
            let x = CGFloat(i) * gridSize + offset
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: size.height))
        }
        
        SKColor.black.setStroke()
        bezierPath.lineWidth = 3.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return SKTexture(image: image!)
    }
    
    func gridPosition(row: Int, column: Int) -> CGPoint {
        let gridOffset = gridSize / 2.0 + 0.5
        let x = (CGFloat(row) * gridSize) + gridOffset
        let y = (CGFloat(column) * gridSize) + gridOffset
        return CGPoint(x: x, y: y)
    }
    
    func indexPath(ofPoint point: CGPoint) -> IndexPath {
        let row = Int(point.x / CGFloat(gridSize))
        let column = Int(point.y / CGFloat(gridSize))
        return IndexPath(row: row, section: column)
    }
}
