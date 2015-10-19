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
        camera.name = "Camera"
        theLevel.addChild(camera)
        camera.position = CGPoint(x: 80, y: 150)
        theScene.camera = camera
    }
    
    func moveCameraToSpawn(position: CGPoint, camera: SKCameraNode) {
        camera.position = CGPoint(x: position.x, y: position.y)
    }
    
    func moveCamera(distance: CGFloat, camera: SKCameraNode) {
            
            let currentX = camera.position.x
            let newX = currentX - distance
            var newPosition = CGPoint(x: newX, y: 150)
            newPosition.x = CGFloat(min(newPosition.x, 410))
            newPosition.x = CGFloat(max(newPosition.x, 80))
        
            
            camera.position = CGPoint(x: newPosition.x, y: 150)
        
    }
}