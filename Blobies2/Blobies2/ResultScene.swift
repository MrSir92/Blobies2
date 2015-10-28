//
//  ResultScene.swift
//  Blobies2
//
//  Created by Kristoffer Sör on 2015-10-27.
//  Copyright © 2015 Kristoffer Sör. All rights reserved.
//

import SpriteKit

class ResultScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        print(scene?.userData?.valueForKey("score"))
        
    }
    
}
