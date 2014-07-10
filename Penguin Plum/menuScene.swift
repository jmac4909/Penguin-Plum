//
//  menuScene.swift
//  Penguin Plum
//
//  Created by Jeremy Mackey on 7/4/14.
//  Copyright (c) 2014 Jeremy Mackey. All rights reserved.
//

import spriteKit
import CoreMotion




var  playButton = SKSpriteNode(imageNamed: "PlayButton")
var  storeButton = SKSpriteNode(imageNamed: "storeButton")








class menuScene: SKScene {

   

    
    override func didMoveToView(view: SKView!) {
        

        
        
        playButton.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        self .addChild(playButton)
        
        storeButton.position = CGPointMake( playButton.position.x - storeButton.frame.width/2, playButton.position.y - playButton.frame.height)
        self .addChild(storeButton)
        
        
        self.backgroundColor = UIColor .whiteColor()
        
 


        
        
        
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        
            for touch: AnyObject in touches {
            let location = touch.locationInNode(self.scene)

                
            if CGRectContainsPoint(playButton.frame, location){
                
                    var scene:GameScene!
                    
                    scene = GameScene(size: self.view.bounds.size)
                    scene.scaleMode = .AspectFill
                    
                    // Present the scene.
                let transition = SKTransition .doorsOpenVerticalWithDuration(2)
                
         

                self .removeAllChildren()
                
                self.view.presentScene(scene, transition: transition)

                

                
                

    
        }
                if CGRectContainsPoint(storeButton.frame, location){
                
                
                    var scene = shopScene(size: self.view.frame.size)
                    scene.scaleMode = .AspectFill
                                        
                    // Present the scene.
                    let transition2 = SKTransition .doorwayWithDuration(1)
                    
                    
                    self .removeAllChildren()
                    
                    self.view.presentScene(scene, transition: transition2)
                    
                    
                    
                    
                    
                    
                    
                }
                
    
        
    }
    
    
    
    
    }
    
    
    
}

