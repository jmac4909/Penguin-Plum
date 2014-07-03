//
//  GameViewController.swift
//  Penguin Plum
//
//  Created by Jeremy Mackey on 6/22/14.
//  Copyright (c) 2014 Jeremy Mackey. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        skView.showsFPS = true
        skView.showsNodeCount = false
        skView.showsPhysics = false
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
       
        // Present the scene.
        skView.presentScene(scene)
    }
}