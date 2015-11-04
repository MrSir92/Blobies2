//
//  GameScene.swift
//  Blobies2
//
//  Created by Kristoffer Sör on 2015-10-07.
//  Copyright (c) 2015 Kristoffer Sör. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var victoryCondition: Bool = false
    var isForfeitButton = false
    var blobdeathcount = 0
    var blobies: [BlobNode] = []
    var TheLevel: Level!
    var theCamera: SKCameraNode!
    var smudgeDestroyer: Bool = false
    var blobDestroyer: Bool = false
    var smudgeToBeDestroyed: SKShapeNode!
    var blobToBeDestroyed: SKSpriteNode!
    var saveSmudge: Bool = false
    var smudges: [SKShapeNode]!
    var TwoFingersTouching: Bool = false
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
    
    var lastPoint = CGPoint(x: 0, y: 0)
    var ref = CGPathCreateMutable()
    var pathLength = Float(0)
    var useless = 0
    
    let blobName = "Blobie"
    let smudgeName = "Smudge"
    let smudgeColor = SKColor(red: 0.19, green: 0.84, blue: 0.94, alpha: 1)
    let smudgeWidth = CGFloat(4)
    let smudgeFriction = CGFloat(5.0)
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.contactDelegate = self
        self.anchorPoint = CGPointMake(0, 0);
        
        self.TheLevel = Level(progress: 1);
        TheLevel.position = CGPoint(x: 0, y: 0)
        addChild(TheLevel);
        
        self.theCamera = SKCameraNode()
        self.theCamera.name = "Camera"
        self.TheLevel.addChild(self.theCamera)
        self.theCamera.position = CGPoint(x: 80, y: 150)
        self.camera = self.theCamera

        let darkBrownColor = UIColor(red:0.4, green:0.3, blue:0.2, alpha:1);
        
        self.backgroundColor = darkBrownColor;

        self.spawnBlobNode(CGPoint(x: 50, y: 200))
        var blobCount = 1
        
        let wait = SKAction.waitForDuration(4)
        let run = SKAction.runBlock {
            if (blobCount < 10) {
                self.spawnBlobNode(CGPoint(x: 50, y: 200))
                blobCount++
            }
            else{
                self.victoryCondition = true
            }
        }
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
        
        //Forfeit Button
        
        let forfeitButton = SKShapeNode(rectOfSize: CGSize(width: 25, height: 25))
        forfeitButton.name = "forfeitButton";
        forfeitButton.fillColor = SKColor(red: 4, green: 4, blue: 0, alpha: 1);
        forfeitButton.position = CGPoint(x: 450, y: 125);
        theCamera.addChild(forfeitButton)
        let forfeitButtonLabel = SKLabelNode(fontNamed: "buttonLabel")
        forfeitButtonLabel.name = "forfeitButton"
        forfeitButtonLabel.text = "x"
        forfeitButtonLabel.position = CGPoint(x: 450, y: 118)
        forfeitButtonLabel.fontColor = SKColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        forfeitButtonLabel.fontSize = 20
        theCamera.addChild(forfeitButtonLabel)
        
    }
    
    func singleTouchBegan(location: CGPoint) {
        CGPathMoveToPoint(ref , nil, location.x, location.y)
        lastPoint.x = location.x
        lastPoint.y = location.y
        // Select the sprite where the touch occurred.
        self.isSprite = checkIfNodeIsSprite(location)
        self.isSmudge = checkIfNodeIsSmudge(location)
        
        if (self.isSprite) {
            let bWait = SKAction.waitForDuration(0)
            let bRun = SKAction.runBlock {
                self.blobDestroyer = true
            }
            self.runAction(SKAction.sequence([bWait, bRun]))
            
        } else if(self.isSmudge) {
            let toWait = SKAction.waitForDuration(1)
            let toRun = SKAction.runBlock {
                if (self.saveSmudge) {
                    self.smudgeDestroyer = false
                    self.saveSmudge = false
                    
                } else {
                    self.smudgeDestroyer = true
                    print(self.smudgeDestroyer)
                }
            }
            self.runAction(SKAction.sequence([toWait, toRun]))
        }
    }
    
    func singleTouchMoved(touches: Set<UITouch>) {
        
        let touch =  touches.first
        let positionInScene = touch!.locationInNode(self)
        

            if (pathLength < Float(100)) {
                CGPathAddLineToPoint(ref, nil, positionInScene.x, positionInScene.y)
                
                let offset = CGPointMake(lastPoint.x - positionInScene.x, lastPoint.y - positionInScene.y)
                let length = sqrtf(Float(offset.x * offset.x + offset.y * offset.y))
                pathLength = pathLength + length
                
                lastPoint.x = positionInScene.x
                lastPoint.y = positionInScene.y
            }
 
    }
    
    func twoFingersMoved(touches: Set<UITouch>) {
        let touch =  touches.first
        
        let positionInScene = touch!.locationInNode(self)
        let toMove = CGFloat(positionInScene.x - lastPoint.x)
        lastPoint.x = positionInScene.x
        moveCameraLeftRight(toMove/2.5)
    }
    
    func drawSmudge() {
        
        
        let lineNode = SKShapeNode();
        lineNode.path = ref
        lineNode.lineWidth = smudgeWidth
        lineNode.name = smudgeName
        lineNode.strokeColor = smudgeColor
        lineNode.physicsBody = SKPhysicsBody(edgeChainFromPath: ref)
        lineNode.physicsBody?.friction = smudgeFriction
        
        lineNode.physicsBody?.categoryBitMask = CollisionTypes.Smudge.rawValue
        lineNode.physicsBody?.contactTestBitMask = CollisionTypes.Smudge.rawValue
        lineNode.physicsBody?.collisionBitMask = CollisionTypes.Wall.rawValue | CollisionTypes.Smudge.rawValue | CollisionTypes.Blob.rawValue
        self.addChild(lineNode)
        if (self.blobDestroyer) {
            blobToDie(blobToBeDestroyed)
            self.blobDestroyer = false
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let firstTouch = touches.first
        self.smudgeDestroyer = false

        if (touches.count < 2) {
            for touch in touches {
                let location = touch.locationInNode(self)
                singleTouchBegan(location)
                
                    self.isForfeitButton = checkIfForfeitButton(location)
                if(self.isForfeitButton) {
                    self.points = 0
                    sceneTransition()
                }
            }
        } else {
            self.TwoFingersTouching = true
            let location = firstTouch!.locationInNode(self)
            lastPoint.x = location.x
            lastPoint.y = location.y
        }
    }
   
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if(!self.TwoFingersTouching) {
        
            if (self.isSprite) {
            
                singleTouchMoved(touches)
            
            }
        } else {
            
            twoFingersMoved(touches)
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.isSprite) {
            
            drawSmudge()
            
        } else if (self.isSmudge) {
            if (self.smudgeDestroyer) {
                smudgeToDie(smudgeToBeDestroyed)
                self.smudgeDestroyer = false
            } else {
                self.saveSmudge = true
                self.smudgeDestroyer = false
            }
        }
        ref = CGPathCreateMutable()
        
        pathLength = Float(0)
        if (self.isSmudge) {
            print(self.smudgeDestroyer)
            if (self.smudgeDestroyer) {
                smudgeToDie(smudgeToBeDestroyed)
                self.smudgeDestroyer = false
            } else {
                self.saveSmudge = true
                self.smudgeDestroyer = false
            }
        }
        
        self.isSmudge = false
        self.isSprite = false
        lastPoint.x = (self.view?.center.x)!
        self.TwoFingersTouching = false

    }

    
    func spawnBlobNode(point: CGPoint) {
        
        let blob = BlobNode.blob(point)
        blob.name = blobName
        self.addChild(blob)
        self.blobies.append(blob)
        var moveDistance = CGFloat(10000)
        moveDistance = moveDistance * 1
        blob.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVector(dx: 1000, dy: 0), duration: 40)))
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
            if (touchedNode.name == smudgeName) {
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
        blob.removeFromParent()
        blobdeathcount++
    }
    
    func smudgeToDie(smudge: SKShapeNode) {
        //kill the smudge here.
        smudge.removeFromParent()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
            
        case CollisionTypes.Blob.rawValue | CollisionTypes.Death.rawValue:
            
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
            break;
        }
    }
    
    func moveCameraLeftRight(distance: CGFloat) {
        if (self.theCamera != nil) {
            
            let currentX = self.theCamera.position.x
            let newX = currentX - distance
            var newPosition = CGPoint(x: newX, y: 150)
            newPosition.x = CGFloat(min(newPosition.x, 410))
            newPosition.x = CGFloat(max(newPosition.x, 80))

            self.theCamera.position = CGPoint(x: newPosition.x, y: 150)
        }
    }
    
    func sceneTransition(){
        
        let transition = SKTransition.revealWithDirection(.Down, duration: 1.0)
        
        let nextScene = ResultScene(size: scene!.size)
        nextScene.scaleMode = .AspectFill
        nextScene.userData = NSMutableDictionary()
        nextScene.userData?.setValue(self.points, forKey: "score")
        
        scene?.view?.presentScene(nextScene, transition: transition)
    }
    
    func checkIfForfeitButton(location: CGPoint) ->Bool {
        if let touchedNode = self.nodeAtPoint(location) as? SKShapeNode {
            if (touchedNode.name == "forfeitButton") {
                return true
            }
            return false
        } else if let touchedNode = self.nodeAtPoint(location) as? SKLabelNode {
            if (touchedNode.name == "forfeitButton") {
                return true
            }
        }
        return false
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        for index in blobies{
            index.Update(index)
        }
        if(victoryCondition){
            if(blobdeathcount >= 10){
                sceneTransition()
            }
        }

    }


}
