//
//  GameScene.swift
//  Blobies2
//
//  Created by Kristoffer Sör on 2015-10-07.
//  Copyright (c) 2015 Kristoffer Sör. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    var TheLevel: Level!
    var globalBool: Bool = false
    enum CollisionTypes: UInt32 {
        case Blob = 1
        case Wall = 2
        case Smudge = 4
        case Start = 8
        case Finish = 16
    }
    
    
    override func didMoveToView(view: SKView) {
        
         /* Setup your scene here */
        
        self.anchorPoint = CGPointMake(0, 0);
        
        self.TheLevel = Level(progress: 1);
        TheLevel.position = CGPoint(x: 0, y: 0)
        addChild(TheLevel);
        
        let darkBrownColor = UIColor(red:0.4, green:0.3, blue:0.2, alpha:1);
        //let lightBrownColor = UIColor(red:0.6, green:0.5, blue:0.4, alpha:1);
        
        self.backgroundColor = darkBrownColor;
        
        TheLevel.moveCamera(-210);

        self.TheLevel.spawnBlobNode(CGPoint(x: 250, y: 200))
        var blobCount = 1
        
        var wait = SKAction.waitForDuration(4)
        var run = SKAction.runBlock {
            if (blobCount < 5) {
                self.TheLevel.spawnBlobNode(CGPoint(x: 250, y: 200))
                blobCount++
            }
        }
        
            self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
            
        
    }
    
    var lastPoint = CGPoint(x: 0, y: 0)
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            CGPathMoveToPoint(ref , nil, location.x, location.y)
            lastPoint.x = location.x
            lastPoint.y = location.y
            // Select the sprite where the touch occurred.
            var isSprite = checkIfNodeIsSprite(location)
            
            if (isSprite) {
                self.globalBool = true;
                
            } else {
                self.globalBool = false;
            }
            
            
        }
    }
    var ref = CGPathCreateMutable()
    var pathLength = Float(0)
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var touch =  touches.first
        
        //var positionInScene = touch.locationInNode(self)
        var positionInScene = touch!.locationInNode(self)
        
        if (self.globalBool) {
            //TODO: Set the lengthlimit.
            //TODO: Check if the lengthlimit has been reached:
            //TODO: After each for-loop, check how long the subpath is.
            //TODO: If the total length of the subpath is reached, don't add the
            //latest subpath and end the for-loop.
            
            for touch: AnyObject in touches {
                if (pathLength < Float(100)) {
                    let locationInScene = touch.locationInNode(self)
                    CGPathAddLineToPoint(ref, nil, positionInScene.x, positionInScene.y)
                    
                    let offset = CGPointMake(lastPoint.x - positionInScene.x, lastPoint.y - positionInScene.y)
                    let length = sqrtf(Float(offset.x * offset.x + offset.y * offset.y))
                    pathLength = pathLength + length
                    
                    lastPoint.x = positionInScene.x
                    lastPoint.y = positionInScene.y
                }
            }
            
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var lineNode = SKShapeNode();
        lineNode.path = ref
        lineNode.lineWidth = 4
        lineNode.strokeColor = UIColor.redColor()
        lineNode.physicsBody = SKPhysicsBody(polygonFromPath: ref)
        lineNode.physicsBody?.categoryBitMask = CollisionTypes.Blob.rawValue
        lineNode.physicsBody?.contactTestBitMask = CollisionTypes.Blob.rawValue
        self.addChild(lineNode)
        ref = CGPathCreateMutable()
        print(pathLength)
        pathLength = Float(0)
    }
    
    
    func checkIfNodeIsSprite(location: CGPoint) ->Bool {
        if let touchedNode = self.nodeAtPoint(location) as? SKSpriteNode {
            print("Selected sprite with name: " + touchedNode.name!)
            return true
        }
        return false
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}
