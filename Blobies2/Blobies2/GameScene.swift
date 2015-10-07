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
    
    
    override func didMoveToView(view: SKView) {
        
         /* Setup your scene here */
        
        self.anchorPoint = CGPointMake(0.16, 0);
        
        self.TheLevel = Level(progress: 1);
        TheLevel.position = CGPoint(x: 0, y: 0)
        addChild(TheLevel);
        
        let darkBrownColor = UIColor(red:0.4, green:0.3, blue:0.2, alpha:1);
        let lightBrownColor = UIColor(red:0.6, green:0.5, blue:0.4, alpha:1);
        
        self.backgroundColor = darkBrownColor;
        
        self.TheLevel.spawnBlobNode(CGPoint(x: 50, y: 150))
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            CGPathMoveToPoint(ref , nil, location.x, location.y)
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
                let locationInScene = touch.locationInNode(self)
                CGPathAddLineToPoint(ref, nil, positionInScene.x, positionInScene.y)
                
            }
            
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var lineNode = SKShapeNode();
        lineNode.path = ref
        lineNode.lineWidth = 8
        lineNode.strokeColor = UIColor.redColor()
        lineNode.physicsBody = SKPhysicsBody(polygonFromPath: ref)
        self.addChild(lineNode)
        ref = CGPathCreateMutable()
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
