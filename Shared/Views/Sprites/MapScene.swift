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
    private var startMovementPoint = CGPoint.zero
    
    private var centerPoint: CGPoint {
        return size.point.center
    }
    private var offset: CGPoint = .zero
    
    private var backgroundNode: ImageNode!
    private var tiles: [XTileNode] = []
    private var mapGridNode: MapGridNode!
    private var cameraNode: SKCameraNode = SKCameraNode()
    
    init(image: UIImage, gridSize: CGFloat, offset: CGPoint = .zero) {
        // Initial init
        self.image = image
        self.offset = offset
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
            mapGridNode.position = offset.add(point: CGPoint(x: 0, y: gridSize / 2))
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
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 1 {
            guard let touch = touches.first else { return }
            if let mapGrid = self.childNode(withName: "MapGrid") as? MapGridNode {
                let indexPath = mapGrid.indexPath(ofPoint: touch.location(in: self))
                let point = mapGrid.gridPosition(row: indexPath.row, column: indexPath.section)
                let removeNodes = nodes(at: point)

                if let node = removeNodes.first(where: { $0.name != "MapGrid" && $0.name != "Background" }) {
                    node.removeFromParent()
                    tiles.removeAll(where: { $0 == node })
                } else {
                    guard let xTile = XTileNode(gridSize: mapGridNode.gridSize) else { return }
                    print(mapGrid.size, size)
                    tiles.append(xTile)
                    xTile.name = "\(tiles.count)"
                    xTile.position = point.add(point: offset)
                    xTile.zPosition = 3
                    self.addChild(xTile)
                }
            }
        }
    }
    
    func updateMapGrid(gridSize: CGFloat, offset: CGPoint) {
        if let gridNode = MapGridNode(gridSize: gridSize, imageSize: size) {
            self.offset = offset
            if let removeNode = childNode(withName: "MapGrid") {
                removeNode.removeFromParent()
            }
            mapGridNode = gridNode
            mapGridNode.zPosition = 2
            mapGridNode.anchorPoint = .zero
            mapGridNode.position = offset.add(point: CGPoint(x: 0, y: gridSize / 2))
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
    
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        if sender.numberOfTouches == 2 {
            if sender.state == .began {
                startMovementPoint = sender.location(in: view)
            }
            if sender.state == .changed {
                let newLocation = sender.location(in: view)
                let change = startMovementPoint.subtract(point: newLocation)
                let scale = cameraNode.xScale / 0.5
                let actualChange = CGPoint(x: change.x, y: change.y * -1.0).scale(by: scale)
                cameraNode.position = cameraNode.position.add(point: actualChange)
                startMovementPoint = newLocation
            }
        } else if sender.numberOfTouches == 1 {
            if sender.state == .changed {
                if let mapGrid = self.childNode(withName: "MapGrid") as? MapGridNode {
                    let location = convertPoint(fromView: sender.location(in: view))
                    let indexPath = mapGrid.indexPath(ofPoint: location)
                    let point = mapGrid.gridPosition(row: indexPath.row, column: indexPath.section)
                    print("\(#function) 1 Touch, point: \(point)")
                    
                    if nodes(at: point).count < 3 {
                        guard let pathTile = PathTile(gridSize: mapGrid.gridSize) else { return }
                        pathTile.position = point.add(point: offset)
                        pathTile.zPosition = 3
                        self.addChild(pathTile)
                    }
                }
            }
        }
    }
}
