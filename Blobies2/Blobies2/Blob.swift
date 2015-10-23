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
    
    internal var goingRight = true
    
    public class func blob(location: CGPoint) -> BlobNode {
        let sprite = BlobNode(imageNamed:"blob.png")
        
        sprite.xScale = 0.075
        sprite.yScale = 0.075
        sprite.position = location
        return sprite
    }
    
    func Update() -> Bool{
        
        if checkWallCollide(self.position.x){
            //flipDirection()
            return true
        } else {
            return false
        }
        
    }
    
    func switchDistance() {
        self.distance = self.distance * -1
    }
    
    /*func switchDistance(index: BlobNode) {
        if(goingRight) {
            //self.distance = self.distance * -1
            index.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVector(dx: -10000, dy: 0), duration: 200)))
            goingRight = false
        } else {
            index.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVector(dx: 10000, dy: 0), duration: 200)))
            goingRight = true
        }
    }
    
    func startMove(index: BlobNode) {
        index.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVector(dx: distance, dy: 0), duration: 200)))
    }*/

    
    func getDistance() -> CGFloat {
        return self.distance
    }
    
    func flipDirection(){
        distance *= -1
        
        self.runAction(SKAction .repeatActionForever(SKAction.moveByX(distance, y: 0, duration: duration)))
    }
    
    func checkWallCollide(position: CGFloat) -> Bool {
        
        var sum = CGFloat(0)
        
        let buffer = CGFloat(0.5)
        
        
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
                
                    
                    //print("----------------------")
                    //print(sum)
                    //print("----------------------")
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
