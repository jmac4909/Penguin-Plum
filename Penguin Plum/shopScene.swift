//
//  shopScene.swift
//  Penguin Plum
//
//  Created by Jeremy Mackey on 7/8/14.
//  Copyright (c) 2014 Jeremy Mackey. All rights reserved.
//

import spriteKit






//Lines
var line1 = SKSpriteNode(imageNamed: "line")
var line2 = SKSpriteNode(imageNamed: "line")
var line3 = SKSpriteNode(imageNamed: "line")

var snowHatOutfit = 0
var bunnyHatOutfit = 0
var topHatOutfit = 0
var vikingHatOutfit = 0



var backButton = SKSpriteNode(imageNamed: "backButton")



//Hat 1
var snowHatButton = SKSpriteNode(imageNamed: "snowCap")
var snowHatLabel = SKLabelNode(fontNamed: "Copperplate-Bold")
var buyRibbon1 = SKSpriteNode(imageNamed: "buyRibbon")


//Hat 2
var bunnyHatButton = SKSpriteNode(imageNamed: "bunnyHat")
var bunnyHatLabel = SKLabelNode(fontNamed: "Copperplate-Bold")
var buyRibbon2 = SKSpriteNode(imageNamed: "buyRibbon")


//Hat 3
var topHatButton = SKSpriteNode(imageNamed: "topHat")
var topHatLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
var buyRibbon3 = SKSpriteNode(imageNamed: "buyRibbon")

//Hat 4
var vikingHatButton = SKSpriteNode(imageNamed: "vikingHat")
var vikingHatLabel = SKLabelNode(fontNamed: "Copperplate-Bold")
var buyRibbon4 = SKSpriteNode(imageNamed: "buyRibbon")


class shopScene: SKScene {
    
    
    override func didMoveToView(view: SKView!) {
        unHighlightLabels()
        
    
        //coin Label
        coinLabel.text = "x \(coinNum)"
        coinLabel.fontSize = 20
        coinLabel.position = CGPointMake(self.frame.width - coinLabel.frame.width/2, self.frame.height - 35)
        self .addChild(coinLabel)
        
        //Cornner Coin
        cornerCoin = SKSpriteNode(imageNamed: "Coin")
        cornerCoin .setScale(0.5)
        
        cornerCoin.position = CGPointMake(coinLabel.position.x - coinLabel.frame.width/2 - cornerCoin.frame.width/2, self.frame.height - 35 + cornerCoin.frame.height/2)
        self .addChild(cornerCoin)
        
        
        
        //add buttons to buy outfits and what not
        
        self.backgroundColor = UIColor .cyanColor()
        
        currentOutfit = userDefaults .integerForKey("currentOutfit")
        
        snowHatOutfit = userDefaults .integerForKey("snowHatOutfit")
        bunnyHatOutfit = userDefaults .integerForKey("bunnyHatOutfit")
        topHatOutfit = userDefaults .integerForKey("topHatOutfit")
        vikingHatOutfit = userDefaults .integerForKey("vikingHatOutfit")

        backButton.position = CGPointMake(10 + backButton.frame.width/2, self.frame.height - backButton.frame.height)
        self .addChild(backButton)
        
        
        
        //Hat 1
        snowHatButton .setScale(0.2)

        snowHatButton.position = CGPointMake((self.frame.width/2)/2, (self.frame.height/2) + (self.frame.height/2)/2 + snowHatButton.frame.height/2)
    
        self .addChild(snowHatButton)
        snowHatLabel.position = CGPointMake(snowHatButton.position.x, snowHatButton.position.y - snowHatButton.frame.height - snowHatLabel.frame.height)
        snowHatLabel.fontSize = 15
        
        snowHatLabel.text = "Snow Cap"
        self .addChild(snowHatLabel)
    
        buyRibbon1.position = snowHatButton.position
        self .addChild(buyRibbon1)
        
        //Hat 2
        bunnyHatButton.position = CGPointMake((self.frame.width/2) + (self.frame.width/2)/2, (self.frame.height/2) + (self.frame.height/2)/2 + snowHatButton.frame.height)
        bunnyHatButton .setScale(0.2)
        self .addChild(bunnyHatButton)
        bunnyHatLabel.position = CGPointMake(bunnyHatButton.position.x, bunnyHatButton.position.y - bunnyHatButton.frame.height - bunnyHatLabel.frame.height)
        bunnyHatLabel.fontSize = 15
        bunnyHatLabel.text = "Bunny Ears"
        self .addChild(bunnyHatLabel)
        
        buyRibbon2.position = bunnyHatButton.position
        self .addChild(buyRibbon2)
        
        //Hat 3
        topHatButton.position = CGPointMake((self.frame.width/2)/2, self.frame.height/2)
        topHatButton .setScale(0.04)
        self .addChild(topHatButton)
        topHatLabel.position = CGPointMake(topHatButton.position.x, topHatButton.position.y - topHatButton.frame.height/2 - topHatLabel.frame.height)
        topHatLabel.text = "Top Hat"
        topHatLabel.fontSize = 15
        self .addChild(topHatLabel)
        
        buyRibbon3.position = topHatButton.position
        self .addChild(buyRibbon3)
        
        //Hat 4
        vikingHatButton.position = CGPointMake(bunnyHatButton.position.x, topHatButton.position.y)
        vikingHatButton .setScale(0.1)
        self .addChild(vikingHatButton)
        vikingHatLabel.position = CGPointMake(vikingHatButton.position.x, vikingHatButton.position.y - vikingHatButton.frame.height - vikingHatLabel.frame.height)
        vikingHatLabel.text = "Viking Hat"
        vikingHatLabel.fontSize = 15
        self .addChild(vikingHatLabel)
        
        buyRibbon4.position = vikingHatButton.position
        self .addChild(buyRibbon4)
        
        
        
        
        
        
        
        
        //Lines
        line1.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        self .addChild(line1)
        line2.position = CGPointMake(self.frame.width/2, self.frame.height/3)
        line2.zRotation = 1.570796326794897
        self .addChild(line2)
        line3.position = CGPointMake(self.frame.width/2, (self.frame.height/3) + (self.frame.height/3))
        line3.zRotation = 1.570796326794897
        self .addChild(line3)
        
        
        
        
        
        

        
        
        if currentOutfit == 0 {
            
        }else if currentOutfit == 1{
            snowHatLabel.fontColor = UIColor .yellowColor()

        }else if currentOutfit == 2{
            bunnyHatLabel.fontColor = UIColor .yellowColor()

        }else if currentOutfit == 3{
            topHatLabel.fontColor = UIColor .yellowColor()
            
        }else if currentOutfit == 4{
            vikingHatLabel.fontColor = UIColor .yellowColor()
            
        }else if currentOutfit == 5{
            
        }else if currentOutfit == 6{

        
        }

        
        //If snow hat has been bought
        if snowHatOutfit == 0 {
            buyRibbon1.hidden = false
        }else{
            buyRibbon1.hidden = true
        }
        
        //if bunny hat has been bought
        if bunnyHatOutfit == 0{
            buyRibbon2.hidden = false
        }else{
            buyRibbon2.hidden = true
        }
        
        //if top hat has been bought
        if topHatOutfit == 0 {
            buyRibbon3.hidden = false
        }else{
            buyRibbon3.hidden = true
        }
        
        //if Viking Hat has been bought
        if vikingHatOutfit == 0{
            buyRibbon4.hidden = false
        }else{
            
            buyRibbon4.hidden = true
        }
        
    
        
        
    }
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        let location = touches.anyObject().locationInNode(self)
        
        if CGRectContainsPoint(backButton.frame, location){
            
            returnToMenu()
      
            
        }
        //Hat 1
        if CGRectContainsPoint(snowHatButton.frame, location){
            
            
            //snow Hat is outfit 1
            if snowHatOutfit == 0 && coinNum >= 100{
                //buys and sets snow hat
                coinNum -= 100
                snowHatOutfit = 1
                currentOutfit = 1
                unHighlightLabels()
                snowHatLabel.fontColor = UIColor .yellowColor()
                buyRibbon1.hidden = true
                
            }else if snowHatOutfit == 1{
                if currentOutfit != 1{
                    currentOutfit = 1
                    unHighlightLabels()
                    snowHatLabel.fontColor = UIColor .yellowColor()
                }else{
                    
                    currentOutfit = 0
                    snowHatLabel.fontColor = UIColor .grayColor()
                    
                }
                
                
            }
            userDefaults .setInteger(snowHatOutfit, forKey: "snowHatOutfit")
            userDefaults .setInteger(currentOutfit, forKey: "currentOutfit")
            userDefaults .setInteger(coinNum, forKey: "coin")
            userDefaults .synchronize()
            
            
        }
        
        //Hat 2
        if CGRectContainsPoint(bunnyHatButton.frame, location){
            
            
            //bunny Hat is outfit 1
            if bunnyHatOutfit == 0 && coinNum >= 100{
                //buys and sets snow hat
                coinNum -= 100
                bunnyHatOutfit = 1
                currentOutfit = 2
                unHighlightLabels()
                bunnyHatLabel.fontColor = UIColor .yellowColor()
                buyRibbon2.hidden = true
                
            }else if bunnyHatOutfit == 1{
                if currentOutfit != 2{
                    
                    currentOutfit = 2
                    unHighlightLabels()
                    bunnyHatLabel.fontColor = UIColor .yellowColor()
                }else{
                    
                    currentOutfit = 0
                    bunnyHatLabel.fontColor = UIColor .grayColor()
                    
                }
                
                
            }
            userDefaults .setInteger(bunnyHatOutfit, forKey: "bunnyHatOutfit")
            userDefaults .setInteger(currentOutfit, forKey: "currentOutfit")
            userDefaults .setInteger(700, forKey: "coin")
            userDefaults .synchronize()
            
            
        }

        
        
        
        
        //Hat 3
        if CGRectContainsPoint(topHatButton.frame, location){
           
            
            //Top Hat is outfit 3
            if topHatOutfit == 0 && coinNum >= 100{
                //buys and sets top hat
                coinNum -= 100
                topHatOutfit = 1
                currentOutfit = 3
                topHatLabel.fontColor = UIColor .yellowColor()
                buyRibbon3.hidden = true
                
            }else if topHatOutfit == 1{
                if currentOutfit != 3{
                currentOutfit = 3
                unHighlightLabels()
                topHatLabel.fontColor = UIColor .yellowColor()
                }else{
                    
                    currentOutfit = 0
                    topHatLabel.fontColor = UIColor .grayColor()
                }
                

            }
            userDefaults .setInteger(topHatOutfit, forKey: "topHatOutfit")
            userDefaults .setInteger(currentOutfit, forKey: "currentOutfit")
            userDefaults .setInteger(coinNum, forKey: "coin")
            userDefaults .synchronize()
        
        
        }
        
        //Hat 4
        if CGRectContainsPoint(vikingHatButton.frame, location){
            
            //Viking Hat is outfit 4
            if vikingHatOutfit == 0 && coinNum >= 100{
                
                //buys and sets viking hat
                coinNum -= 100
                vikingHatOutfit = 1
                currentOutfit = 4
                vikingHatLabel.fontColor = UIColor .yellowColor()
                buyRibbon4.hidden = true
                
            }else if vikingHatOutfit == 1{
                if currentOutfit != 4{
                    currentOutfit = 4
                    unHighlightLabels()
                    vikingHatLabel.fontColor = UIColor .yellowColor()
                }else{
                    
                    currentOutfit = 0
                    vikingHatLabel.fontColor = UIColor .grayColor()
                    
                }
                
                
            }
            userDefaults .setInteger(vikingHatOutfit, forKey: "vikingHatOutfit")
            userDefaults .setInteger(currentOutfit, forKey: "currentOutfit")
            userDefaults .setInteger(coinNum, forKey: "coin")
            userDefaults .synchronize()
            
        }
        
        
       

    }
    
    func returnToMenu(){
        
        var scene:menuScene!
        
        scene = menuScene(size: self.view.bounds.size)
        scene.scaleMode = .AspectFill
        
        // Present the scene.
        let transition = SKTransition .doorsOpenVerticalWithDuration(2)
        
        
        
        self .removeAllChildren()
        
        self.view.presentScene(scene)
        
        
        
    
        
    }
    func unHighlightLabels(){
        
        
        snowHatLabel.fontColor = UIColor .grayColor()
        bunnyHatLabel.fontColor = UIColor .grayColor()
        topHatLabel.fontColor = UIColor .grayColor()
        vikingHatLabel.fontColor = UIColor .grayColor()

    }
    
    override func update(currentTime: NSTimeInterval) {
        
        
        
        scoreLabel.text = "Score: \(score)"
        coinLabel.text = "x \(coinNum)"
        coinLabel.position = CGPointMake(self.frame.width - coinLabel.frame.width/2, self.frame.height - 35)
        cornerCoin.position = CGPointMake(coinLabel.position.x - coinLabel.frame.width/2 - cornerCoin.frame.width/2, self.frame.height - 35 + cornerCoin.frame.height/2)

        
        
        
        
        
        
    }
    
}
