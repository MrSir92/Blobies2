//
//  GameScene.swift
//  Blobies
//
//  Created by Emil Lind on 2015-09-30.
//  Copyright (c) 2015 Emil's app house. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //var World: SKNode!
    //var Camera: SKNode!
    var TheLevel: Level!
    var globalBool: Bool = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.anchorPoint = CGPointMake(0.16, 0);
        
        self.TheLevel = Level(progress: 1);
        TheLevel.position = CGPoint(x: 0, y: 0)
        addChild(TheLevel);
        
        /*self.World = SKNode()
        self.World.name = "World"
        addChild(self.World)
        self.Camera = SKNode()
        self.Camera.name = "Camera"
        self.World.addChild(self.Camera)
        */
        let darkBrownColor = UIColor(red:0.4, green:0.3, blue:0.2, alpha:1);
        let lightBrownColor = UIColor(red:0.6, green:0.5, blue:0.4, alpha:1);
        //self.backgroundColor = darkBrownColor;
        self.backgroundColor = darkBrownColor;
        /*var ground1 = SKShapeNode(rectOfSize: CGSize(width: 130, height: 30));
        ground1.name = "ground1";
        ground1.fillColor = lightBrownColor;
        ground1.position = CGPoint(x: 0, y: 110);
        World.addChild(ground1);
        var ground2 = SKShapeNode(rectOfSize: CGSize(width: 30, height: 30));
        ground2.name = "ground1";
        ground2.fillColor = lightBrownColor;
        ground2.position = CGPoint(x: 115, y: 110);
        World.addChild(ground2);
        let myLabel = SKLabelNode(fontNamed:"Chalkduster");
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        World.addChild(myLabel);*/
        
        self.TheLevel.spawnBlobNode(CGPoint(x: 50, y: 150))
        
        
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            // Record initial location of touch.
            let touch = touches.anyObject() as UITouch
            let location = touch.locationInNode(self)
            CGPathMoveToPoint(ref, nil, location.x, location.y)
            
            // Select the sprite where the touch occurred.
            var isSprite = checkIfNodeIsSprite(location)
            
            if (isSprite) {
                self.globalBool = true;
                
            } else {
                self.globalBool = false;
            }
            
            /*let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)*/
        }
    }
    var ref = CGPathCreateMutable()
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch!
        var positionInScene = touch.locationInNode(self)

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
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
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
            println("Selected sprite with name: " + touchedNode.name!)
            return true
        }
        return false
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //TheLevel.Camera.position = CGPoint(x: 700, y: 0)
        //TheLevel.moveCamera(300);
        //self.didFinishUpdate();
    }
    
    override func didFinishUpdate() {
        
        //TheLevel.Camera.position = CGPoint(x: 700, y: 0)
        //TheLevel.moveCamera(300);
        //self.centerOnNode(TheLevel.Camera)
        
    }

    func centerOnNode(node: SKNode) {
        
        //let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: World)
        
        //println(cameraPositionInScene);
        
        let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: TheLevel)

        
        node.parent!.runAction(SKAction.moveTo(CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y - cameraPositionInScene.y), duration: 1))

        
        /*node.parent!.position = CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y - cameraPositionInScene.y)
        */
    }
}
