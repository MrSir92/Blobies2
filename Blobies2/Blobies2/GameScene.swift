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
            
            //CGPathMoveToPoint(ref, nil, location.x, location.y)
            CGPathMoveToPoint(, <#T##m: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>, <#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>)
            // Select the sprite where the touch occurred.
            var isSprite = checkIfNodeIsSprite(location)
            
            if (isSprite) {
                self.globalBool = true;
                
            } else {
                self.globalBool = false;
            }
            
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
