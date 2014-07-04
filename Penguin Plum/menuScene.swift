//
//  menuScene.swift
//  Penguin Plum
//
//  Created by Jeremy Mackey on 7/4/14.
//  Copyright (c) 2014 Jeremy Mackey. All rights reserved.
//

import spriteKit
import CoreMotion



let  playButton = SKSpriteNode(imageNamed: "PlayButton")
let motionManager: CMMotionManager = CMMotionManager()
let screenSize: CGRect = UIScreen.mainScreen().bounds

var buttonXspeed:CGFloat = 0.0
var buttonYspeed:CGFloat = 0.0

class menuScene: SKScene {
   
    
    override func didMoveToView(view: SKView!) {
        
        motionManager .startAccelerometerUpdates()
        
        if (motionManager.accelerometerAvailable) {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue()) {
                (data, error) in
                
                if(data.acceleration.y < -0.25) { // tilting the device to the right
                    
                    buttonYspeed = -500
                    
                } else if (data.acceleration.y > 0.25) { // tilting the device to the left
                    
                

                    buttonYspeed = 500
                }
                if(data.acceleration.x < -0.25) { // tilting the device to the right
                    
                    buttonXspeed = -500
                    
                } else if (data.acceleration.x > 0.25) { // tilting the device to the left
                    
                    
                    
                    buttonXspeed = 500
                }

            }
        }
        
       self.backgroundColor = UIColor .whiteColor()
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        
        playButton.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        playButton.physicsBody = SKPhysicsBody(circleOfRadius: playButton.frame.width/2)
        self .addChild(playButton)
        
        
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
                    self.view.presentScene(scene)
                    
                    

            }
                
                

    
        }
    
        
    }
    
    
    override func update(currentTime: NSTimeInterval) {

        
        
        playButton.physicsBody.velocity = CGVectorMake(buttonXspeed, buttonYspeed)
    
        
    }
    
    
    
    
    
    
    
}
