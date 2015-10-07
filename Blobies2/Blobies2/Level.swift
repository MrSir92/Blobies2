//
//  Level.swift
//  Blobies2
//
//  Created by Kristoffer Sör on 2015-10-07.
//  Copyright © 2015 Kristoffer Sör. All rights reserved.
//

import UIKit
import SpriteKit

class Level: SKNode {
    
    var Camera: SKNode!
    var World: SKNode!
    
    convenience init(progress: Int) {
        self.init();
        
        self.World = SKNode()
        self.World.name = "World"
        addChild(self.World)
        
        self.Camera = SKNode()
        self.Camera.name = "Camera"
        World.addChild(self.Camera)
        
        switch(progress){
        case 1:
            
            //let darkBrownColor = UIColor(red:0.4, green:0.3, blue:0.2, alpha:1);
            let lightBrownColor = UIColor(red:0.6, green:0.5, blue:0.4, alpha:1);
            //self.backgroundColor = darkBrownColor;
            let roof1 = SKShapeNode(rectOfSize: CGSize(width: 150, height: 300));
            roof1.name = "roof1";
            roof1.fillColor = lightBrownColor;
            roof1.position = CGPoint(x: 74, y: 400);
            roof1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 150, height: 300))
            roof1.physicsBody?.dynamic = false;
            World.addChild(roof1);
            let wall1 = SKShapeNode(rectOfSize: CGSize(width: 20, height: 140));
            wall1.name = "wall1";
            wall1.fillColor = lightBrownColor;
            wall1.position = CGPoint(x: 9, y: 180);
            wall1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 20, height: 140))
            wall1.physicsBody?.dynamic = false;
            World.addChild(wall1);
            let ground1 = SKShapeNode(rectOfSize: CGSize(width: 200, height: 30));
            ground1.name = "ground1";
            ground1.fillColor = lightBrownColor;
            ground1.position = CGPoint(x: 99, y: 110);
            ground1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 30))
            ground1.physicsBody?.dynamic = false;
            World.addChild(ground1);
            let ground2 = SKShapeNode(rectOfSize: CGSize(width: 30, height: 30));
            ground2.name = "ground1";
            ground2.fillColor = lightBrownColor;
            ground2.position = CGPoint(x: 245, y: 110);
            ground2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 30))
            ground2.physicsBody?.dynamic = false;
            World.addChild(ground2);
            let ground3 = SKShapeNode(rectOfSize: CGSize(width: 100, height: 30))
            ground3.name = "ground3";
            ground3.fillColor = lightBrownColor;
            ground3.position = CGPoint(x: 370, y: 110);
            ground3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 100, height: 30))
            ground3.physicsBody?.dynamic = false;
            World.addChild(ground3)
            let ground4 = SKShapeNode(rectOfSize: CGSize(width: 50, height: 30))
            ground4.name = "ground4";
            ground4.fillColor = lightBrownColor;
            ground4.position = CGPoint(x: 475, y: 110);
            ground4.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 50, height: 30))
            ground4.physicsBody?.dynamic = false;
            World.addChild(ground4)
            let ground5 = SKShapeNode(rectOfSize: CGSize(width: 150, height: 60))
            ground5.name = "ground5";
            ground5.fillColor = lightBrownColor;
            ground5.position = CGPoint(x: 575, y: 125);
            ground5.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 150, height: 60))
            ground5.physicsBody?.dynamic = false;
            World.addChild(ground5)
            let ground6 = SKShapeNode(rectOfSize: CGSize(width: 150, height: 30))
            ground6.name = "ground6";
            ground6.fillColor = lightBrownColor;
            ground6.position = CGPoint(x: 825, y: 110);
            ground6.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 150, height: 30))
            ground6.physicsBody?.dynamic = false;
            World.addChild(ground6)
            let wall2 = SKShapeNode(rectOfSize: CGSize(width: 20, height: 230))
            wall2.name = "wall2";
            wall2.fillColor = lightBrownColor;
            wall2.position = CGPoint(x: 910, y: 210);
            wall2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 20, height: 230))
            wall2.physicsBody?.dynamic = false;
            World.addChild(wall2)
            print("levelstarted")
        default:
            print("wrong level")
        }
        
    }
    
    func moveCamera(xPoint: CGFloat) {
        //println("hoho")
        if (self.Camera != nil) {
            self.Camera.position = CGPoint(x: xPoint, y: 0)
            //println("hejhopp")
            self.centerOnNode(self.Camera)
        }
    }
    
    func centerOnNode(node: SKNode) {
        
        //let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: World)
        
        //println(cameraPositionInScene);
        
        let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: World)
        //print(cameraPositionInScene)
        
        node.parent!.runAction(SKAction.moveTo(CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y - cameraPositionInScene.y), duration: 0.1))
        
        
        /*node.parent!.position = CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y - cameraPositionInScene.y)
        */
    }
    
    func spawnBlobNode(point: CGPoint) {
        let sprite = BlobNode.blob(point)
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height/2)
        sprite.physicsBody!.allowsRotation = false
        sprite.name = "Blobie1"
        self.addChild(sprite)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        sprite.runAction(SKAction.moveByX(10000, y: 0, duration: 1000))
    }
    
}
