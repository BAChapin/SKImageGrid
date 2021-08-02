//
//  CGSizeExtension.swift
//  CGSizeExtension
//
//  Created by Brett Chapin on 8/1/21.
//

import SwiftUI

extension CGSize {
    
    struct PointSystem {
        var topLeft: CGPoint
        var topRight: CGPoint
        var center: CGPoint
        var bottomLeft: CGPoint
        var bottomRight: CGPoint
        
        init(_ size: CGSize) {
            self.topLeft = CGPoint(x: 0, y: 0)
            self.topRight = CGPoint(x: size.width, y: 0)
            self.center = CGPoint(x: size.width / 2, y: size.height / 2)
            self.bottomLeft = CGPoint(x: 0, y: size.height)
            self.bottomRight = CGPoint(x: size.width, y: size.height)
        }
    }
    
    var point: PointSystem {
        return PointSystem(self)
    }
    
    func add(width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: self.width + width, height: self.height + height)
    }
}
