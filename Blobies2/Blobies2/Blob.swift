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
    
    internal var positions: [CGFloat] = [250]
    
    internal var distance = CGFloat(10000)
    internal var duration = NSTimeInterval(1000)
    
    internal var goingRight = true
    
    public class func blob(location: CGPoint) -> BlobNode {
        let blob = BlobNode(imageNamed:"blob.png")
        
        blob.physicsBody = SKPhysicsBody(circleOfRadius: blob.size.height/2)
        blob.physicsBody!.allowsRotation = false
        blob.physicsBody?.linearDamping = 0.2
        blob.physicsBody?.categoryBitMask = CollisionTypes.Blob.rawValue
        blob.physicsBody?.contactTestBitMask = CollisionTypes.Blob.rawValue | CollisionTypes.Death.rawValue
        blob.physicsBody?.collisionBitMask = CollisionTypes.Wall.rawValue | CollisionTypes.Smudge.rawValue
        
        blob.xScale = 0.075
        blob.yScale = 0.075
        blob.position = location
        return blob
    }
    
    func Update(index: BlobNode){
        print(self)
        if checkWallCollide(self.position.x){

            switchDistance(index)

        }
    }
    

func switchDistance(index: BlobNode) {

        if(goingRight) {
            index.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVector(dx: -10000, dy: 0), duration: 200)))
            goingRight = false
        } else {
            index.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVector(dx: 10000, dy: 0), duration: 200)))
            goingRight = true
        }
    }
    
    func checkWallCollide(position: CGFloat) -> Bool {
        
        var sum = CGFloat(0)
        
        let buffer = CGFloat(0.5)
        
        
        if self.positions.count == 9{
            positions.removeAtIndex(8)
        }
        
        self.positions.insert(position, atIndex: 0)
        
        sum = self.positions.reduce(0, combine: +)
        
        
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
