//
//  Blob.swift
//  Blobies
//
//  Created by Emil Lind on 2015-10-02.
//  Copyright (c) 2015 Emil's app house. All rights reserved.
//

import UIKit
import SpriteKit

class BlobNode: SKSpriteNode {
    class func blob(location: CGPoint) -> BlobNode {
        let sprite = BlobNode(imageNamed:"blob.png")
        
        sprite.xScale = 0.075
        sprite.yScale = 0.075
        sprite.position = location
        return sprite
    }

}
