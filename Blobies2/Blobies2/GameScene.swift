//
//  GameScene.swift
//  Blobies2
//
//  Created by Kristoffer Sör on 2015-10-07.
//  Copyright (c) 2015 Kristoffer Sör. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var TheLevel: Level!
    var globalBool: Bool = false
    var smudgeDestroyer: Bool = false
    var blobDestroyer: Bool = false
    var smudgeToBeDestroyed: SKShapeNode!
    var blobToBeDestroyed: SKSpriteNode!
    var saveSmudge: Bool = false
    var smudges: [SKShapeNode]!
    enum CollisionTypes: UInt32 {
        case Blob = 1
        case Wall = 2
        case Smudge = 4
        case Start = 8
        case Finish = 16
        case Death = 32
    }
    
    
    override func didMoveToView(view: SKView) {
        
         /* Setup your scene here */
        
        physicsWorld.contactDelegate = self
        
        self.anchorPoint = CGPointMake(0, 0);
        
        self.TheLevel = Level(progress: 1);
        TheLevel.position = CGPoint(x: 0, y: 0)
        addChild(TheLevel);
        
        let darkBrownColor = UIColor(red:0.4, green:0.3, blue:0.2, alpha:1);
        //let lightBrownColor = UIColor(red:0.6, green:0.5, blue:0.4, alpha:1);
        
        self.backgroundColor = darkBrownColor;
        
        TheLevel.moveCamera(-210);

        self.spawnBlobNode(CGPoint(x: 250, y: 200))
        var blobCount = 1
        
        var wait = SKAction.waitForDuration(4)
        var run = SKAction.runBlock {
            if (blobCount < 10) {
                self.spawnBlobNode(CGPoint(x: 250, y: 200))
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
            var isSmudge = checkIfNodeIsSmudge(location)
            
            if (isSprite) {
                self.globalBool = true;
                var bWait = SKAction.waitForDuration(0)
                var bRun = SKAction.runBlock {
                    self.blobDestroyer = true
                }
                self.runAction(SKAction.sequence([bWait, bRun]))
            } else if(isSmudge) {
                var toWait = SKAction.waitForDuration(1.5)
                var toRun = SKAction.runBlock {
                    print(self.smudgeDestroyer)
                    if (!self.saveSmudge) {
                        self.smudgeDestroyer = true
                        print(self.smudgeDestroyer)
                    } else {
                        self.smudgeDestroyer = false
                    }
                }
                self.runAction(SKAction.sequence([toWait, toRun]))
            }else {
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
        if (self.globalBool) {
            var lineNode = SKShapeNode();
            lineNode.path = ref
            lineNode.lineWidth = 4
            lineNode.name = "Smudge"
            lineNode.strokeColor = UIColor.redColor()
            lineNode.physicsBody = SKPhysicsBody(polygonFromPath: ref)
            lineNode.physicsBody?.friction = 5.0
            lineNode.physicsBody?.categoryBitMask = CollisionTypes.Smudge.rawValue
            lineNode.physicsBody?.contactTestBitMask = CollisionTypes.Smudge.rawValue
            self.addChild(lineNode)
            //self.smudges.append(lineNode)
            if (self.blobDestroyer) {
                blobToDie(blobToBeDestroyed)
                self.blobDestroyer = false
            }
        }
        ref = CGPathCreateMutable()
        
        //print(pathLength)
        pathLength = Float(0)
        if (self.smudgeDestroyer) {
            smudgeToDie(smudgeToBeDestroyed)
            self.smudgeDestroyer = false
        } else {
            print(self.smudgeDestroyer)
            print(self.saveSmudge)
            self.smudgeDestroyer = false
        }
    }
    
    
    func checkIfNodeIsSprite(location: CGPoint) ->Bool {
        if let touchedNode = self.nodeAtPoint(location) as? SKSpriteNode {
            self.blobToBeDestroyed = touchedNode
            print("Selected sprite with name: " + touchedNode.name!)
            return true
        }
        return false
    }
    
    func checkIfNodeIsSmudge(location: CGPoint) ->Bool {
        if let touchedNode = self.nodeAtPoint(location) as? SKShapeNode {
            if (touchedNode.name == "Smudge") {
                self.smudgeToBeDestroyed = touchedNode
                print("Selected Smudge")
                return true
            }
            return false
        }
        return false
    }
    
    func blobToDie(blob: SKSpriteNode) {
        //Kill the blob here.
        //print("blob just died!...")
        blob.removeFromParent()
    }
    
    func smudgeToDie(smudge: SKShapeNode) {
        //kill the smudge here.
        //print("smudge just got destroyed...")
        smudge.removeFromParent()
    }
    var useless = 0
    func didBeginContact(contact: SKPhysicsContact) {
        
        // Step 1. Bitiwse OR the bodies' categories to find out what kind of contact we have
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
            
        case CollisionTypes.Blob.rawValue | CollisionTypes.Death.rawValue:
            
            // Step 2. Disambiguate the bodies in the contact
            if contact.bodyA.categoryBitMask == CollisionTypes.Blob.rawValue {
                blobToDie(contact.bodyA.node as! SKSpriteNode)
            } else {
                blobToDie(contact.bodyB.node as! SKSpriteNode)
            }
            
        
        default:
            useless++
            // Nobody expects this, so satisfy the compiler and catch
            // ourselves if we do something we didn't plan to
            //fatalError("other collision: \(contactMask)")
        }
    }
    
    var blobies: [BlobNode] = []
    
    func spawnBlobNode(point: CGPoint) {
        let sprite = BlobNode.blob(point)
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height/2)
        sprite.physicsBody!.allowsRotation = false
        sprite.physicsBody?.linearDamping = 0.2
        sprite.physicsBody?.categoryBitMask = CollisionTypes.Blob.rawValue
        sprite.physicsBody?.contactTestBitMask = CollisionTypes.Blob.rawValue | CollisionTypes.Death.rawValue
        sprite.physicsBody?.collisionBitMask = CollisionTypes.Wall.rawValue | CollisionTypes.Smudge.rawValue
        sprite.name = "Blobie1"
        self.addChild(sprite)
        self.blobies.append(sprite)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        sprite.runAction(SKAction.moveByX(10000, y: 0, duration: 1000))
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //if let toWrite = self.blobies {
            print(self.blobies)
        //}
    }
}
