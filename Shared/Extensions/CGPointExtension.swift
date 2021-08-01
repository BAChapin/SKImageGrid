//
//  CGPointExtension.swift
//  CGPointExtension
//
//  Created by Brett Chapin on 8/1/21.
//

import SwiftUI

extension CGPoint {
    func add(point: CGPoint) -> CGPoint {
        return CGPoint(x: x + point.x, y: y + point.y)
    }
    
    func subtract(point: CGPoint) -> CGPoint {
        return CGPoint(x: x - point.x, y: y - point.y)
    }
}
