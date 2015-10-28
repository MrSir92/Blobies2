//
//  ResultScene.swift
//  Blobies2
//
//  Created by Kristoffer Sör on 2015-10-27.
//  Copyright © 2015 Kristoffer Sör. All rights reserved.
//

import SpriteKit

class ResultScene: SKScene {
    
    var isRestartButton = false
    
    override func didMoveToView(view: SKView) {
        
        let newHighScore = checkForHighScore()
        printCurrentScore()
        if (newHighScore) {
            
        }else {
            
        }
        
        let restartButton = SKShapeNode(rectOfSize: CGSize(width: 50, height: 50))
        restartButton.name = "restartButton";
        restartButton.fillColor = SKColor(red: 4, green: 4, blue: 0, alpha: 1);
        restartButton.position = CGPoint(x: 500, y: 50);
        self.addChild(restartButton)
        
    }
    
    func printCurrentScore() {
        if let theScore = scene?.userData?.valueForKey("score") as? NSNumber {
            print(theScore)
            
            let labelText = SKLabelNode(fontNamed: "label")
            labelText.text = "You scored: "
            labelText.position = CGPoint(x: 500, y: 280)
            labelText.fontSize = 30
            labelText.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.addChild(labelText)
            let scoreText = SKLabelNode(fontNamed: "toPrint")
            scoreText.text = String(theScore)
            scoreText.position = CGPoint(x: 500, y: 250);
            scoreText.fontSize = 30
            scoreText.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.addChild(scoreText)
    
        }
    }
    
    func checkForHighScore() -> Bool {
    
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            self.isRestartButton = checkIfRestartButton(location)
            if(self.isRestartButton) {
                restartLevel()
            }
        }
    }
    
    func checkIfRestartButton(location: CGPoint) ->Bool {
        if let touchedNode = self.nodeAtPoint(location) as? SKShapeNode {
            if (touchedNode.name == "restartButton") {
                return true
            }
            return false
        }
        return false
    }
    
    func restartLevel() {
        let transition = SKTransition.revealWithDirection(.Down, duration: 1.0)
        
        let nextScene = GameScene(size: scene!.size)
        nextScene.scaleMode = .AspectFill
        
        scene?.view?.presentScene(nextScene, transition: transition)
    }
    
}
