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
    

    var World: SKNode!
    enum CollisionTypes: UInt32 {
        case Blob = 1
        case Wall = 2
        case Smudge = 4
        case Start = 8
        case Finish = 16
        case Death = 32
    }
    
    convenience init(progress: Int) {
        self.init();
        
        
        self.World = SKNode()
        self.World.name = "World"
        addChild(self.World)
        
        
        
        switch(progress){
        case 1:
            
            //let darkBrownColor = UIColor(red:0.4, green:0.3, blue:0.2, alpha:1);
            let lightBrownColor = UIColor(red:0.6, green:0.5, blue:0.4, alpha:1);
            //self.backgroundColor = darkBrownColor;
            let spawnPoint = SKShapeNode(rectOfSize: CGSize(width: 30, height: 200))
            spawnPoint.name = "spawnPoint"
            spawnPoint.fillColor = SKColor(red: 0, green: 0.7, blue: 0, alpha: 1)
            spawnPoint.position = CGPoint(x: 50, y: 310)
            World.addChild(spawnPoint)
            let roof1 = SKShapeNode(rectOfSize: CGSize(width: 150, height: 300));
            roof1.name = "roof1";
            roof1.fillColor = lightBrownColor;
            roof1.position = CGPoint(x: 74, y: 400);
            roof1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 150, height: 300))
            roof1.physicsBody?.dynamic = false;
            roof1.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(roof1);
            let wall1 = SKShapeNode(rectOfSize: CGSize(width: 20, height: 140));
            wall1.name = "wall1";
            wall1.fillColor = lightBrownColor;
            wall1.position = CGPoint(x: 9, y: 180);
            wall1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 20, height: 140))
            wall1.physicsBody?.dynamic = false;
            wall1.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(wall1);
            let ground1 = SKShapeNode(rectOfSize: CGSize(width: 200, height: 30));
            ground1.name = "ground1";
            ground1.fillColor = lightBrownColor;
            ground1.position = CGPoint(x: 99, y: 110);
            ground1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 200, height: 30))
            ground1.physicsBody?.dynamic = false;
            ground1.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground1);
            let ground2 = SKShapeNode(rectOfSize: CGSize(width: 30, height: 30));
            ground2.name = "ground1";
            ground2.fillColor = lightBrownColor;
            ground2.position = CGPoint(x: 245, y: 110);
            ground2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 30))
            ground2.physicsBody?.dynamic = false;
            ground2.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground2);
            let ground3 = SKShapeNode(rectOfSize: CGSize(width: 100, height: 30))
            ground3.name = "ground3";
            ground3.fillColor = lightBrownColor;
            ground3.position = CGPoint(x: 370, y: 110);
            ground3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 100, height: 30))
            ground3.physicsBody?.dynamic = false;
            ground3.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground3)
            let ground4 = SKShapeNode(rectOfSize: CGSize(width: 50, height: 30))
            ground4.name = "ground4";
            ground4.fillColor = lightBrownColor;
            ground4.position = CGPoint(x: 475, y: 110);
            ground4.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 50, height: 30))
            ground4.physicsBody?.dynamic = false;
            ground4.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground4)
            let ground5 = SKShapeNode(rectOfSize: CGSize(width: 150, height: 60))
            ground5.name = "ground5";
            ground5.fillColor = lightBrownColor;
            ground5.position = CGPoint(x: 575, y: 125);
            ground5.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 150, height: 60))
            ground5.physicsBody?.dynamic = false;
            ground5.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground5)
            let ground6 = SKShapeNode(rectOfSize: CGSize(width: 150, height: 30))
            ground6.name = "ground6";
            ground6.fillColor = lightBrownColor;
            ground6.position = CGPoint(x: 825, y: 110);
            ground6.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 150, height: 30))
            ground6.physicsBody?.dynamic = false;
            ground6.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground6)
            let wall2 = SKShapeNode(rectOfSize: CGSize(width: 20, height: 230))
            wall2.name = "wall2";
            wall2.fillColor = lightBrownColor;
            wall2.position = CGPoint(x: 910, y: 210);
            wall2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 20, height: 230))
            wall2.physicsBody?.dynamic = false;
            wall2.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(wall2)
            print("levelstarted")
            let deathGround = SKShapeNode(rectOfSize: CGSize(width: 1000, height: 30))
            deathGround.name = "deathGround"
            deathGround.position = CGPoint(x: 500, y: 10)
            deathGround.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1000, height: 30))
            deathGround.physicsBody?.dynamic = false
            deathGround.alpha = 0
            deathGround.physicsBody?.categoryBitMask = CollisionTypes.Death.rawValue
            deathGround.physicsBody?.contactTestBitMask = CollisionTypes.Blob.rawValue
            World.addChild(deathGround)
            let finishLine = SKShapeNode(rectOfSize: CGSize(width: 30, height: 30))
            finishLine.name = "finishLine"
            finishLine.position = CGPoint(x: 870, y: 140)
            finishLine.fillColor = SKColor(red: 0.7, green: 0.7, blue: 0, alpha: 1)
            finishLine.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 30))
            finishLine.physicsBody?.dynamic = false
            finishLine.physicsBody?.categoryBitMask = CollisionTypes.Finish.rawValue
            finishLine.physicsBody?.contactTestBitMask = CollisionTypes.Blob.rawValue
            World.addChild(finishLine)
        default:
            print("wrong level")
        }
        
    }
    
    
    
    
    
}
