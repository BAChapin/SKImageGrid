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
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(_:)))
        view.addGestureRecognizer(pinchGesture)
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
    
    @objc func pinchAction(_ sender: UIPinchGestureRecognizer) {
        if sender.numberOfTouches == 2 {
            let locationInView = sender.location(in: view)
            let location = self.convertPoint(fromView: locationInView)
            if sender.state == .changed {
                let deltaScale = (sender.scale - 1.0) * 2
                let convertedScale = sender.scale - deltaScale
                let newScale = cameraNode.xScale * convertedScale
                cameraNode.setScale(newScale >= 1 ? 1.0 : newScale)
                
                let locationAfterScale = convertPoint(fromView: locationInView)
                let locationDelta = location.subtract(point: locationAfterScale)
                let newPoint = cameraNode.position.add(point: locationDelta)
                cameraNode.position = (newScale >= 1 ? centerPoint : newPoint)
                sender.scale = 1.0
            }
        }
        
        
    }
}
