//
//  MapScene.swift
//  MapScene
//
//  Created by Brett Chapin on 8/1/21.
//

import SwiftUI
import SpriteKit

class MapScene: SKScene {
    var image: UIImage
    private var previousCameraScale = CGFloat()
    
    private var centerPoint: CGPoint {
        return size.midPoint()
    }
    
    private var backgroundNode: ImageNode!
    private var mapGridNode: MapGridNode!
    private var cameraNode: SKCameraNode = SKCameraNode()
    
    init(image: UIImage, gridSize: CGFloat, offset: CGPoint = .zero) {
        // Initial init
        self.image = image
        let size = image.size
        super.init(size: size)
        self.scaleMode = .aspectFit
        self.anchorPoint = .zero
        
        // Setup Background Node
        backgroundNode = ImageNode(image: image, nodeName: "Background")
        backgroundNode.anchorPoint = .zero
        backgroundNode.zPosition = 1
        self.addChild(backgroundNode)
        
        // Setup Map Grid
        if let gridNode = MapGridNode(gridSize: gridSize, imageSize: image.size) {
            mapGridNode = gridNode
            mapGridNode.zPosition = 2
            mapGridNode.anchorPoint = .zero
            mapGridNode.position = offset
            self.addChild(mapGridNode)
        }
        
        // Setup Camera
        cameraNode.position = centerPoint
        cameraNode.xScale = 1
        cameraNode.yScale = 1
        self.addChild(cameraNode)
        self.camera = cameraNode
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.image = UIImage()
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        return
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        return
    }
    
    func updateMapGrid(gridSize: CGFloat, offset: CGPoint) {
        if let gridNode = MapGridNode(gridSize: gridSize, imageSize: size) {
            if let removeNode = childNode(withName: "MapGrid") {
                removeNode.removeFromParent()
            }
            mapGridNode = gridNode
            mapGridNode.zPosition = 2
            mapGridNode.anchorPoint = .zero
            mapGridNode.position = offset
            addChild(mapGridNode)
        }
    }
}
