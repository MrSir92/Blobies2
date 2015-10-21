//
//  GameScene.swift
//  Blobies2
//
//  Created by Kristoffer Sör on 2015-10-07.
//  Copyright (c) 2015 Kristoffer Sör. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var blobies: [BlobNode] = []
    var TheLevel: Level!
    var theCamera: SKCameraNode!
    var globalBool: Bool = false
    var smudgeDestroyer: Bool = false
    var blobDestroyer: Bool = false
    var smudgeToBeDestroyed: SKShapeNode!
    var blobToBeDestroyed: SKSpriteNode!
    var saveSmudge: Bool = false
    var smudges: [SKShapeNode]!
    var TwoFingers: Bool = false
    enum CollisionTypes: UInt32 {
        case Blob = 1
        case Wall = 2
        case Smudge = 4
        case Start = 8
        case Finish = 16
        case Death = 32
    }
    var points = 0
    
    var isSprite: Bool = false
    var isSmudge: Bool = false
    
    
    override func didMoveToView(view: SKView) {
        
         /* Setup your scene here */
        
        physicsWorld.contactDelegate = self
        
        self.anchorPoint = CGPointMake(0, 0);
        
        self.TheLevel = Level(progress: 1);
        TheLevel.position = CGPoint(x: 0, y: 0)
        addChild(TheLevel);
        
        //self.Camera = SKCameraNode.self
        self.theCamera = SKCameraNode()
        self.theCamera.name = "Camera"
        self.TheLevel.addChild(self.theCamera)
        self.theCamera.position = CGPoint(x: 80, y: 150)
        self.camera = self.theCamera

        let darkBrownColor = UIColor(red:0.4, green:0.3, blue:0.2, alpha:1);
        //let lightBrownColor = UIColor(red:0.6, green:0.5, blue:0.4, alpha:1);
        
        self.backgroundColor = darkBrownColor;
        
        //moveCameraToSpawn(CGPoint(x: -210, y: 0))

        self.spawnBlobNode(CGPoint(x: 50, y: 200))
        var blobCount = 1
        
        var wait = SKAction.waitForDuration(4)
        var run = SKAction.runBlock {
            if (blobCount < 10) {
                self.spawnBlobNode(CGPoint(x: 50, y: 200))
                blobCount++
            }
        }
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
        
        //let gestureRecognizer = UIPanGestureRecognizer(target: self, action: ("handlePanFrom:"))
        //self.view!.addGestureRecognizer(gestureRecognizer)
        
    }
    

    
    
    var lastPoint = CGPoint(x: 0, y: 0)
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        var i = 0
        //print(touches.count)
        let firstTouch = touches.first
        self.smudgeDestroyer = false

        if (touches.count < 2) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            CGPathMoveToPoint(ref , nil, location.x, location.y)
            lastPoint.x = location.x
            lastPoint.y = location.y
            // Select the sprite where the touch occurred.
            self.isSprite = checkIfNodeIsSprite(location)
            self.isSmudge = checkIfNodeIsSmudge(location)

            if (self.isSprite) {
                self.globalBool = true;
                var bWait = SKAction.waitForDuration(0)
                var bRun = SKAction.runBlock {
                    self.blobDestroyer = true
                }
                self.runAction(SKAction.sequence([bWait, bRun]))

            } else if(self.isSmudge) {
                var toWait = SKAction.waitForDuration(1)
                var toRun = SKAction.runBlock {
                    //print(self.smudgeDestroyer)
                    //print("began...")
                    //print(self.saveSmudge)
                    if (self.saveSmudge) {
                        self.smudgeDestroyer = false
                        self.saveSmudge = false
                        
                        //print(self.smudgeDestroyer)
                    } else {
                        self.smudgeDestroyer = true
                    print(self.smudgeDestroyer)
                    }
                }
                self.runAction(SKAction.sequence([toWait, toRun]))
            }else {
                self.globalBool = false;
            }
        }
        } else {
            for touch in touches {
            self.TwoFingers = true
            let location = firstTouch!.locationInNode(self)
            lastPoint.x = location.x
            lastPoint.y = location.y
            }
        }
    }
    var ref = CGPathCreateMutable()
    var pathLength = Float(0)
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        var touch =  touches.first
        
        if(!self.TwoFingers) {
        
        
        
        //var positionInScene = touch.locationInNode(self)
        var positionInScene = touch!.locationInNode(self)
        
        if (self.globalBool) {
            var tempVar = 0
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
        } else {
            let positionInScene = touch!.locationInNode(self)
            for touch: AnyObject in touches {
                
                    let locationInScene = touch.locationInNode(self)
                    //CGPathAddLineToPoint(ref, nil, positionInScene.x, positionInScene.y)
                
                    //let toMove = CGFloat(lastPoint.x - positionInScene.x)
                    let toMove = CGFloat(positionInScene.x - lastPoint.x)
                lastPoint.x = positionInScene.x
                    //lastPoint.x = self.theCamera.position.x
                    moveCamera(toMove/2.5)
                
            }
        }
    }
    
    /*func handlePanFrom(recognizer: UIPanGestureRecognizer) {

                    let pos = self.theCamera.position
                var translation = recognizer.translationInView(recognizer.view!)
                    translation = CGPoint(x: translation.x, y: -translation.y)
                    // This just multiplies your velocity with the scroll duration.
                    let p = CGPoint(x: velocity.x * CGFloat(scrollDuration), y: velocity.y * CGFloat(scrollDuration))
                    
                    var newPos = CGPoint(x: pos.x + p.x, y: pos.y + p.y)
                    moveCamera(newPos.x)

        
    }*/
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.globalBool) {
            var lineNode = SKShapeNode();
            lineNode.path = ref
            lineNode.lineWidth = 4
            lineNode.name = "Smudge"
            lineNode.strokeColor = SKColor(red: 0.19, green: 0.84, blue: 0.94, alpha: 1)
            lineNode.physicsBody = SKPhysicsBody(edgeChainFromPath: ref)
            //Få till så en Smudge kan falla...
            lineNode.physicsBody?.mass = 1.0
            lineNode.physicsBody?.dynamic = true
            lineNode.physicsBody?.friction = 5.0
            
            lineNode.physicsBody?.categoryBitMask = CollisionTypes.Smudge.rawValue
            lineNode.physicsBody?.contactTestBitMask = CollisionTypes.Smudge.rawValue
            lineNode.physicsBody?.collisionBitMask = CollisionTypes.Wall.rawValue | CollisionTypes.Smudge.rawValue | CollisionTypes.Blob.rawValue
            self.addChild(lineNode)
            //self.smudges.append(lineNode)
            if (self.blobDestroyer) {
                blobToDie(blobToBeDestroyed)
                self.blobDestroyer = false
            }
            self.globalBool = false
        }
        ref = CGPathCreateMutable()
        
        //print(pathLength)
        if (self.isSmudge) {
        pathLength = Float(0)
            print(self.smudgeDestroyer)
        if (self.smudgeDestroyer) {
            smudgeToDie(smudgeToBeDestroyed)
            self.smudgeDestroyer = false
        } else {
            print("hejhopp")
            //print(self.smudgeDestroyer)
            //print(self.saveSmudge)
            self.saveSmudge = true
            self.smudgeDestroyer = false
        }
        }
        self.isSmudge = false
        self.isSprite = false
        lastPoint.x = (self.view?.center.x)!
        self.TwoFingers = false
    }

    
    func spawnBlobNode(point: CGPoint) {
        let blob = BlobNode.blob(point)
        blob.name = "Blobie"
        self.TheLevel.addChild(blob)
        self.blobies.append(blob)
        var moveDistance = CGFloat(10000)
        moveDistance = moveDistance * 1
        blob.runAction(SKAction.moveBy(CGVector(dx: 1000, dy: 0), duration: 40))
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
            
        case CollisionTypes.Blob.rawValue | CollisionTypes.Finish.rawValue:
            if contact.bodyA.collisionBitMask == CollisionTypes.Blob.rawValue {
                blobToDie(contact.bodyA.node as! SKSpriteNode)
            } else {
                blobToDie(contact.bodyB.node as! SKSpriteNode)
            }
            self.points++
            print("Your total points are:" + String(points))
        
        default:
            useless++
            // Nobody expects this, so satisfy the compiler and catch
            // ourselves if we do something we didn't plan to
            //fatalError("other collision: \(contactMask)")
        }
    }


    func moveCameraToSpawn(position: CGPoint) {
        if (self.theCamera != nil) {
            self.theCamera.position = CGPoint(x: position.x, y: position.y)
            self.centerOnNode(self.theCamera)
        }
    }
    
    func moveCamera(distance: CGFloat) {
        //println("hoho")
        if (self.theCamera != nil) {
            //let winSize = self.size
            
            let currentX = self.theCamera.position.x
            let newX = currentX - distance
            var newPosition = CGPoint(x: newX, y: 150)
            newPosition.x = CGFloat(min(newPosition.x, 410))
            newPosition.x = CGFloat(max(newPosition.x, 80))
            let time = Double(distance)/2
            
            /*if (newX > 80){
                
                if (newX < 410) {
                    self.theCamera.runAction(SKAction.moveByX(distance, y: 0, duration: time))
                }
            }*/
                //(CGPoint(x: newPosition.x, y: 150), duration: 0))

            self.theCamera.position = CGPoint(x: newPosition.x, y: 150)
            //println("hejhopp")
            //self.centerOnNode(self.theCamera)
        }
    }
    
    func centerOnNode(node: SKNode) {
        
        //let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: World)
        
        //println(cameraPositionInScene);
        
        let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: self.TheLevel)
        //print(cameraPositionInScene)
        
        node.parent!.runAction(SKAction.moveTo(CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y - cameraPositionInScene.y), duration: 0.0))
        
        
        
        /*node.parent!.position = CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y - cameraPositionInScene.y)
        */
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //if let toWrite = self.blobies {

            //	print(self.blobies)
        for index in blobies{
            index.Update(index)
            /*
            var toTurn = index.Update()
            if(toTurn) {
                //index.switchDistance(index)
                index.switchDistance()
                var distance = index.getDistance()
                index.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVector(dx: distance, dy: 0), duration: 200)))
            }
            */
        }
            //print(self.blobies)
            //print(self.blobies)

        //}
    }


}
