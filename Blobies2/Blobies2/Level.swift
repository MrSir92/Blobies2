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
            
            let lightBrownColor = UIColor(red:0.6, green:0.5, blue:0.4, alpha:1);
            
            let spawnPoint = SKShapeNode(rectOfSize: CGSize(width: 30, height: 200))
            spawnPoint.name = "spawnPoint"
            spawnPoint.fillColor = SKColor(red: 0, green: 0.7, blue: 0, alpha: 1)
            spawnPoint.position = CGPoint(x: 50, y: 310)
            World.addChild(spawnPoint)
            
            let roof1 = platform("roof1", pos: CGPoint(x:74, y:400), rectSize: CGSize(width: 150, height: 300))
            roof1.fillColor = lightBrownColor;
            roof1.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(roof1);
            
            let wall1 = platform("wall1", pos: CGPoint(x: 9, y: 180), rectSize: CGSize(width: 20, height: 140))
            wall1.fillColor = lightBrownColor;
            wall1.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(wall1);
            
            let ground1 = platform("ground1", pos: CGPoint(x: 99,y: 110), rectSize: CGSize(width: 200, height: 30))
            ground1.fillColor = lightBrownColor;
            ground1.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground1);
            
            let ground2 = platform("ground2", pos: CGPoint(x: 245, y: 110), rectSize: CGSize(width: 30, height: 30))
            ground2.fillColor = lightBrownColor;
            ground2.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground2);
            
            let ground3 = platform("ground3", pos: CGPoint(x: 370, y: 110), rectSize: CGSize(width: 100, height: 30))
            ground3.fillColor = lightBrownColor;
            ground3.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground3)
            
            let ground4 = platform("ground4", pos: CGPoint(x: 475, y: 110), rectSize: CGSize(width: 50, height: 30))
            ground4.fillColor = lightBrownColor;
            ground4.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground4)

            let ground5 = platform("ground5", pos: CGPoint(x: 575, y: 125), rectSize: CGSize(width: 150, height: 60))
            ground5.fillColor = lightBrownColor;
            ground5.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground5)
            
            let ground6 = platform("ground6", pos: CGPoint(x: 825, y: 110), rectSize: CGSize(width: 150, height: 30))
            ground6.fillColor = lightBrownColor;
            ground6.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(ground6)
            
            let wall2 = platform("wall2", pos: CGPoint(x: 910, y: 210), rectSize: CGSize(width: 20, height: 230))
            wall2.fillColor = lightBrownColor;
            wall2.physicsBody?.categoryBitMask = CollisionTypes.Wall.rawValue
            World.addChild(wall2)
            
            print("levelstarted")
            
            let deathGround = platform("deathGround", pos: CGPoint(x: 500, y: 10), rectSize: CGSize(width: 1000, height: 30))
            deathGround.alpha = 0
            deathGround.physicsBody?.categoryBitMask = CollisionTypes.Death.rawValue
            deathGround.physicsBody?.contactTestBitMask = CollisionTypes.Blob.rawValue
            World.addChild(deathGround)
            
            let finishLine = platform("finishLine", pos: CGPoint(x: 870, y: 140), rectSize: CGSize(width: 30, height: 30))
            finishLine.fillColor = SKColor(red: 0.7, green: 0.7, blue: 0, alpha: 1)
            finishLine.physicsBody?.categoryBitMask = CollisionTypes.Finish.rawValue
            finishLine.physicsBody?.contactTestBitMask = CollisionTypes.Blob.rawValue
            World.addChild(finishLine)
        default:
            print("wrong level")
        }
        
    }
    func platform(name: String, pos: CGPoint,rectSize :CGSize) ->SKShapeNode{
        let node = SKShapeNode(rectOfSize: rectSize)
        
        node.name = name
        node.position = pos
        node.physicsBody = SKPhysicsBody(rectangleOfSize: rectSize)
        node.physicsBody?.dynamic = false
        
        
        return node
    }
    
    
    
    
    
}
