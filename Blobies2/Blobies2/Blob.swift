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
    
    //internal var positions: [CGFloat?] = [CGFloat(0)]
    
    internal var positions: [CGFloat] = [250]
    
    internal var distance = CGFloat(10000)
    internal var duration = NSTimeInterval(1000)
    
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
        
        if checkWallCollide(self.position.x){
            flipDirection()
        }
        
    }
    
    func flipDirection(){
        distance *= -1
        
        self.runAction(SKAction.moveByX(distance, y: 0, duration: duration))
    }
    
    func checkWallCollide(position: CGFloat) -> Bool {
        
        var sum = CGFloat(0)
        
        let buffer = CGFloat(3)
        
        
        if positions.count == 10{
            positions.removeAtIndex(9)
        }
        
        positions.insert(position, atIndex: 0)
        
        sum = positions.reduce(0, combine: +)
        //print("----------------------")
        //print(sum/CGFloat(positions.count))
        //print("----------------------")
        
        if positions.count > 8{
            if sum/CGFloat(positions.count) < positions[0] + buffer
                && sum/CGFloat(positions.count) > positions[0] - buffer {
                positions.removeAll()
                return true

                
            }
            else{
                return false
            }
        }
        else{
            return false
        }
    }
}
