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
    var newScore: NSNumber!
    var highScore: NSNumber!
    var existedHighScore = false
    
    override func didMoveToView(view: SKView) {
        printCurrentScore()
        let newHighScore = checkForHighScore()
        if (newHighScore) {
            let preferences = NSUserDefaults.standardUserDefaults()
            
            let currentLevelKey = "firstlevel"
            
            preferences.setDouble(self.newScore.doubleValue, forKey: currentLevelKey)
            

            let didSave = preferences.synchronize()
            
            if !didSave {
                
            }
            let highScoreLabel = SKLabelNode(fontNamed: "highscorelabel")
            highScoreLabel.text = "You scored a new HighScore: "
            highScoreLabel.position = CGPoint(x: 400, y: 280)
            highScoreLabel.fontSize = 15
            highScoreLabel.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.addChild(highScoreLabel)
            let highScoreText = SKLabelNode(fontNamed: "highScore")
            highScoreText.text = String(newScore)
            highScoreText.position = CGPoint(x: 400, y: 250);
            highScoreText.fontSize = 30
            highScoreText.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.addChild(highScoreText)
        } else if (self.existedHighScore) {
            let highScoreLabel = SKLabelNode(fontNamed: "highscorelabel")
            highScoreLabel.text = "Your old HighScore: "
            highScoreLabel.position = CGPoint(x: 400, y: 280)
            highScoreLabel.fontSize = 15
            highScoreLabel.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.addChild(highScoreLabel)
            let highScoreText = SKLabelNode(fontNamed: "highScore")
            highScoreText.text = String(highScore)
            highScoreText.position = CGPoint(x: 400, y: 250);
            highScoreText.fontSize = 30
            highScoreText.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.addChild(highScoreText)
        } else {
            let preferences = NSUserDefaults.standardUserDefaults()
            
            let currentLevelKey = "firstlevel"
            
            preferences.setDouble(self.newScore.doubleValue, forKey: currentLevelKey)
            
            
            let didSave = preferences.synchronize()
            
            if !didSave {
                
            }
            let highScoreLabel = SKLabelNode(fontNamed: "highscorelabel")
            highScoreLabel.text = "You don't have any saved HighScore: "
            highScoreLabel.position = CGPoint(x: 400, y: 280)
            highScoreLabel.fontSize = 15
            highScoreLabel.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.addChild(highScoreLabel)
        }
        
        let restartButton = SKShapeNode(rectOfSize: CGSize(width: 80, height: 30))
        restartButton.name = "restartButton";
        restartButton.fillColor = SKColor(red: 4, green: 4, blue: 0, alpha: 1);
        restartButton.position = CGPoint(x: 500, y: 65);
        self.addChild(restartButton)
        let restartButtonLabe = SKLabelNode(fontNamed: "buttonLabel")
        restartButtonLabe.name = "restartButton"
        restartButtonLabe.text = "Restart"
        restartButtonLabe.position = CGPoint(x: 500, y: 58)
        restartButtonLabe.fontColor = SKColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        restartButtonLabe.fontSize = 18
        self.addChild(restartButtonLabe)
        
    }
    
    func printCurrentScore() {
        if let theScore = scene?.userData?.valueForKey("score") as? NSNumber {
            self.newScore = theScore
            
            let scoreLabel = SKLabelNode(fontNamed: "scorelabel")
            scoreLabel.text = "You scored: "
            scoreLabel.position = CGPoint(x: 600, y: 280)
            scoreLabel.fontSize = 15
            scoreLabel.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.addChild(scoreLabel)
            let scoreText = SKLabelNode(fontNamed: "score")
            scoreText.text = String(newScore)
            scoreText.position = CGPoint(x: 600, y: 250);
            scoreText.fontSize = 30
            scoreText.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.addChild(scoreText)
    
        }
    }
    
    func checkForHighScore() -> Bool {
    
        let preferences = NSUserDefaults.standardUserDefaults()
        
        let currentLevelKey = "firstlevel"
        
        if preferences.objectForKey(currentLevelKey) == nil {
            return false
            self.highScore = 0
        } else {
            self.existedHighScore = true
            self.highScore = preferences.doubleForKey(currentLevelKey)
            if (self.highScore.doubleValue >= self.newScore.doubleValue) {
                return false
            } else {
                return true
            }
            
            
            
            return false
        }
        
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
        } else if let touchedNode = self.nodeAtPoint(location) as? SKLabelNode {
            if (touchedNode.name == "restartButton") {
                return true
            }
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
