//
//  CameraHandler.swift
//  Blobies2
//
//  Created by Emil Lind on 2015-10-12.
//  Copyright © 2015 Kristoffer Sör. All rights reserved.
//

import Foundation
import SpriteKit

protocol CameraHandler {
    
    func moveCameraToSpawn(position: CGPoint)
    
    func moveCamera(distance: CGFloat)
    
}