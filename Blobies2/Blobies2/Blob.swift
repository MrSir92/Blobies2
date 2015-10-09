//
//  Blob.swift
//  Blobies2
//
//  Created by Kristoffer Sör on 2015-10-07.
//  Copyright © 2015 Kristoffer Sör. All rights reserved.
//

import UIKit
import SpriteKit

class BlobNode: SKSpriteNode {
    
    internal var positions = [CGFloat]()
    
    class func blob(location: CGPoint) -> BlobNode {
        let sprite = BlobNode(imageNamed:"blob.png")
        
        sprite.xScale = 0.075
        sprite.yScale = 0.075
        sprite.position = location
        let distanceToMove = 1000
        let moveduration = 500
        return sprite
    }
    
    func Update(){
        
    }
    
    func checkWallCollide(position: CGFloat) -> Bool {
        
        var sum = CGFloat(0)
    
        for i in(9...0){
            positions[i+1] = positions[i]
        }
        positions.removeAtIndex(10)
        
        positions[0] = position
        
        for i in(0...9){
            sum = sum + positions[i]
        }
        
        
        if sum/CGFloat(positions.count) < positions[0] + CGFloat(5)
            || sum/CGFloat(positions.count) > positions[0] - CGFloat(5) {
                
            return true;
                
        }
        else{
            return false;
        }

    }
}
