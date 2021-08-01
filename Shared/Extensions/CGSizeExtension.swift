//
//  CGSizeExtension.swift
//  CGSizeExtension
//
//  Created by Brett Chapin on 8/1/21.
//

import SwiftUI

extension CGSize {
    func add(width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: self.width + width, height: self.height + height)
    }
    
    func midPoint() -> CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }
}
