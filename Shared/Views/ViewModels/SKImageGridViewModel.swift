//
//  SKImageGridViewModel.swift
//  SKImageGridViewModel
//
//  Created by Brett Chapin on 8/1/21.
//

import SwiftUI
import SpriteKit

class SKImageGridViewModel: ObservableObject {
    
    @Published var size: CGFloat = 10.0 {
        didSet {
            if image != nil {
                scene.updateMapGrid(gridSize: size, offset: gridOffset)
            }
        }
    }
    @Published var xOffset: CGFloat = 0.0 {
        didSet {
            if image != nil {
                scene.updateMapGrid(gridSize: size, offset: gridOffset)
            }
        }
    }
    @Published var yOffset: CGFloat = 0.0 {
        didSet {
            if image != nil {
                scene.updateMapGrid(gridSize: size, offset: gridOffset)
            }
        }
    }
    @Published var presentPicker: Bool = false
    @Published var image: UIImage? = nil {
        didSet {
            scene = MapScene(image: image!, gridSize: size, offset: gridOffset)
        }
    }
    @Published var scene: MapScene!
    private var gridOffset: CGPoint {
        return CGPoint(x: -xOffset, y: -yOffset)
    }
}
