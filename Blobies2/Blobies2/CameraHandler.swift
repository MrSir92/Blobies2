//
//  CameraHandler.swift
//  Blobies2
//
//  Created by Emil Lind on 2015-10-12.
//  Copyright © 2015 Kristoffer Sör. All rights reserved.
//

import Foundation
import SpriteKit

class CameraHandler: NSObject {
    
    func spawnCamera(position: CGPoint, camera: SKCameraNode, theLevel: SKNode, theScene: GameScene) {
        let spawnXPosition = CGFloat(80)
        let spawnYPosition = CGFloat(150)
        camera.name = "Camera"
        theLevel.addChild(camera)
        camera.position = CGPoint(x: spawnXPosition, y: spawnYPosition)
        theScene.camera = camera
    }
    
    func moveCameraToSpawn(position: CGPoint, camera: SKCameraNode) {
        camera.position = CGPoint(x: position.x, y: position.y)
    }
    
    func moveCamera(distance: CGFloat, camera: SKCameraNode) {
            let minYPosition = CGFloat(410)
            let maxYPosition = CGFloat(80)
            let constantYPosition = CGFloat(150)
            let currentX = camera.position.x
            let newX = currentX - distance
            var newPosition = CGPoint(x: newX, y: constantYPosition)
            newPosition.x = CGFloat(min(newPosition.x, minYPosition))
            newPosition.x = CGFloat(max(newPosition.x, maxYPosition))
        
            
            camera.position = CGPoint(x: newPosition.x, y: constantYPosition)
        
    }
}