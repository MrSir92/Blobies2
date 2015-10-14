//
//  Blob.swift
//  Blobies2
//
//  Created by Kristoffer Sör on 2015-10-07.
//  Copyright © 2015 Kristoffer Sör. All rights reserved.
//

import UIKit
import SpriteKit

public class BlobNode: SKSpriteNode {
    
    //internal var positions: [CGFloat?] = [CGFloat(0)]
    
    internal var positions: [CGFloat] = [250]
    
    internal var distance = CGFloat(10000)
    internal var duration = NSTimeInterval(1000)
    
    public class func blob(location: CGPoint) -> BlobNode {
        let sprite = BlobNode(imageNamed:"blob.png")
        
        sprite.xScale = 0.075
        sprite.yScale = 0.075
        sprite.position = location
        let distanceToMove = 1000
        let moveduration = 500
        return sprite
    }
    
    func Update(blob: BlobNode){
        print(blob)
        if checkWallCollide(blob.position.x){
            flipDirection(blob)
        }
    }
    
    func switchDistance() {
        self.distance = self.distance * CGFloat(-1)
    }
    

    
    func getDistance() -> CGFloat {
        return self.distance
    }
    
    func flipDirection(blob: BlobNode){
        blob.distance *= -1
        
        blob.runAction(SKAction.moveByX(distance, y: 0, duration: duration))
    }
    
    func checkWallCollide(position: CGFloat) -> Bool {
        
        var sum = CGFloat(0)
        
        let buffer = CGFloat(1)
        
        
        if self.positions.count == 10{
            positions.removeAtIndex(9)
        }
        
        self.positions.insert(position, atIndex: 0)
        
        sum = self.positions.reduce(0, combine: +)
        //print("----------------------")
        //print(sum/CGFloat(self.positions.count))
        //print("----------------------")
        
        if self.positions.count > 8{
            if sum/CGFloat(self.positions.count) < self.positions[0] + buffer
                && sum/CGFloat(self.positions.count) > self.positions[0] - buffer {
                self.positions.removeAll()
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
