//
//  Blob.swift
//  Blobies2
//
//  Created by Kristoffer Sör on 2015-10-07.
//  Copyright © 2015 Kristoffer Sör. All rights reserved.
//

import UIKit
import SpriteKit

enum CollisionTypes: UInt32 {
    case Blob = 1
    case Wall = 2
    case Smudge = 4
    case Start = 8
    case Finish = 16
    case Death = 32
}

public class BlobNode: SKSpriteNode {
    
    //internal var positions: [CGFloat?] = [CGFloat(0)]
    
    internal var positions: [CGFloat] = [250]
    
    internal var distance = CGFloat(10000)
    internal var duration = NSTimeInterval(1000)
    
    public class func blob(location: CGPoint) -> BlobNode {
        let blob = BlobNode(imageNamed:"blob.png")
        //physicsBody = SKPhysicsBody()
        
        blob.physicsBody = SKPhysicsBody(circleOfRadius: blob.size.height/2)
        blob.physicsBody!.allowsRotation = false
        blob.physicsBody?.linearDamping = 0.2
        blob.physicsBody?.categoryBitMask = CollisionTypes.Blob.rawValue
        blob.physicsBody?.contactTestBitMask = CollisionTypes.Blob.rawValue | CollisionTypes.Death.rawValue
        blob.physicsBody?.collisionBitMask = CollisionTypes.Wall.rawValue | CollisionTypes.Smudge.rawValue
        blob.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
        blob.xScale = 0.075
        blob.yScale = 0.075
        blob.position = location
        let distanceToMove = 1000
        let moveduration = 500
        return blob
    }
    
    func Update(){
        print(self)
        if checkWallCollide(self.position.x){
            flipDirection()
        }
    }
    
    func switchDistance() {
        self.distance = self.distance * CGFloat(-1)
    }
    

    
    func getDistance() -> CGFloat {
        return self.distance
    }
    
    func flipDirection(){
        self.distance *= -1
        
        self.runAction(SKAction.moveByX(distance, y: 0, duration: duration))
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
