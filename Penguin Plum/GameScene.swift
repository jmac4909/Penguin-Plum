//
//  GameScene.swift
//  Penguin Plum
//
//  Created by Jeremy Mackey on 6/22/14.
//  Copyright (c) 2014 Jeremy Mackey. All rights reserved.
//

import SpriteKit

let playerXVelocity:CGFloat = 350
let iceBlockScale:CGFloat = 0.5
let iceBlockAlphaDecress:CGFloat = 0.009

var monDropTimer:NSTimer?
var coinDropTimer:NSTimer?
var startTimer = NSTimer()

var ground =  SKSpriteNode()
var player = SKSpriteNode()
var coin = SKSpriteNode()

var iceBlock1 =  SKSpriteNode()
var iceBlock2 =  SKSpriteNode()
var iceBlock3 =  SKSpriteNode()
var iceBlock4 =  SKSpriteNode()
var iceBlock5 =  SKSpriteNode()

var gameStart = false

var shouldDropCoin = true
var canDropMonsters = true

var beforeGameTint = SKSpriteNode()


var retryButton = SKSpriteNode(imageNamed: "Retry")
var menuButton = SKSpriteNode(imageNamed: "Menu")


var iceBlockTexture = SKTexture(imageNamed:"IceBlock")

var iceCrackOne0Texture = SKTexture(imageNamed:"IceBlockCrack1-0")
var iceCrackOne1Texture = SKTexture(imageNamed:"IceBlockCrack1-1")
var iceCrackOne2Texture = SKTexture(imageNamed:"IceBlockCrack1-2")

var iceCrackTwo0Texture = SKTexture(imageNamed:"IceBlockCrack2-0")
var iceCrackTwo1Texture = SKTexture(imageNamed:"IceBlockCrack2-1")
var iceCrackTwo2Texture = SKTexture(imageNamed:"IceBlockCrack2-2")


var birdTexture = SKTexture(imageNamed:"PlayerNOflap")
var flyBirdTexture = SKTexture(imageNamed:"PlayerFlap")


var iceBlock1CollisionNumber = 0
var iceBlock2CollisionNumber = 0
var iceBlock3CollisionNumber = 0
var iceBlock4CollisionNumber = 0
var iceBlock5CollisionNumber = 0

var score = 0
var countDownNum = 3

var scoreLabel = SKLabelNode(fontNamed:"GillSans-BoldItalic")
var countDownLabel = SKLabelNode(fontNamed:"GillSans-BoldItalic")

var playerOnIce1 = false
var playerOnIce2 = false
var playerOnIce3 = false
var playerOnIce4 = false
var playerOnIce5 = false


let PLAYER_CATTEGORY_MASK:UInt32 = 0x1 << 0
let ICEBLOCK1_CATTEGORY_MASK:UInt32 = 0x1 << 1
let ICEBLOCK2_CATTEGORY_MASK:UInt32 = 0x1 << 2
let ICEBLOCK3_CATTEGORY_MASK:UInt32 = 0x1 << 3
let ICEBLOCK4_CATTEGORY_MASK:UInt32 = 0x1 << 4
let ICEBLOCK5_CATTEGORY_MASK:UInt32 = 0x1 << 5
let WALLBLOCK_CATTEGORY_MASK:UInt32 = 0x1 << 6
let GROUND_CATTEGORY_MASK:UInt32 = 0x1 << 7
let COIN_CATTEGORY_MASK:UInt32 = 0x1 << 8
let BROKEICE_CATTEGORY_MASK:UInt32 = 0x1 << 9
let BROKEICEPEICE_CATTEGORY_MASK:UInt32 = 0x1 << 10


var playerOrigXScaleRight:CGFloat = 0.0
var playerOrigXScaleLeft:CGFloat = 0.0



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMoveToView(view: SKView) {

        
        countDownNum = 3
        gameStart = false

        coinDropTimer = nil
        monDropTimer = nil
        
        
        /* Setup your scene here */
        iceBlock1CollisionNumber = 0
        iceBlock2CollisionNumber = 0
        iceBlock3CollisionNumber = 0
        iceBlock4CollisionNumber = 0
        iceBlock5CollisionNumber = 0
        
        iceBlock1.texture = iceBlockTexture
        iceBlock2.texture = iceBlockTexture
        iceBlock3.texture = iceBlockTexture
        iceBlock4.texture = iceBlockTexture
        iceBlock5.texture = iceBlockTexture
        
        score = 0
        
        self .removeAllChildren()
        self .removeAllActions()
        shouldDropCoin = false
        canDropMonsters = false
        
        //Backgroud
        self.backgroundColor = UIColor(red: 65/255, green: 160/255, blue: 222/255, alpha: 1)
        
        
        //Score Label
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 35;
        scoreLabel.position = CGPointMake(self.frame.width/2, self.frame.height - 65)
        self.addChild(scoreLabel)
        
        //Physics
        self.physicsWorld.gravity = CGVectorMake(0, -7)
        let physicsBody = SKPhysicsBody(edgeLoopFromRect:self.frame)
        self.physicsBody = physicsBody
        self.physicsBody.categoryBitMask = WALLBLOCK_CATTEGORY_MASK
        self.physicsWorld.contactDelegate = self

        
        //Player

        birdTexture.filteringMode = SKTextureFilteringMode.Nearest
        player = SKSpriteNode(texture:birdTexture)
        player.position = CGPointMake(self.frame.width/2, 285 + player.frame.height)
        player.physicsBody = SKPhysicsBody(circleOfRadius:player.frame.height/2)
        player.physicsBody.dynamic = true
        player.physicsBody.allowsRotation = false
        
        player.physicsBody.categoryBitMask = PLAYER_CATTEGORY_MASK
        player.physicsBody.collisionBitMask = ICEBLOCK1_CATTEGORY_MASK | ICEBLOCK2_CATTEGORY_MASK | ICEBLOCK3_CATTEGORY_MASK | ICEBLOCK4_CATTEGORY_MASK | ICEBLOCK5_CATTEGORY_MASK | WALLBLOCK_CATTEGORY_MASK | GROUND_CATTEGORY_MASK
        
        player.physicsBody.contactTestBitMask = ICEBLOCK1_CATTEGORY_MASK | ICEBLOCK2_CATTEGORY_MASK | ICEBLOCK3_CATTEGORY_MASK | ICEBLOCK4_CATTEGORY_MASK | ICEBLOCK5_CATTEGORY_MASK | GROUND_CATTEGORY_MASK | COIN_CATTEGORY_MASK
        
        player.setScale(0.5)
        player.physicsBody.density = 0.0001
        self.scene .addChild(player)
        
        

        //Ground
        var groundTexture = SKTexture(imageNamed:"Ground")
        groundTexture.filteringMode = SKTextureFilteringMode.Nearest
        ground = SKSpriteNode(texture:groundTexture)
        ground.position = CGPointMake(self.frame.width/2, ground.frame.height/2)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize:ground.size)
        ground.physicsBody.dynamic = false
        ground.physicsBody.categoryBitMask = GROUND_CATTEGORY_MASK
        self.scene .addChild(ground)
        
        
        //Ice Blocks
        iceBlockTexture.filteringMode = SKTextureFilteringMode.Nearest
        let iceBlockCenter = CGPointMake(iceBlockTexture.size().width/2, iceBlockTexture.size().height/2)
        
        
        iceBlock1 = SKSpriteNode(texture:iceBlockTexture)
        iceBlock1.position = CGPointMake(10,282)
        iceBlock1.anchorPoint = CGPointZero
        iceBlock1.setScale(iceBlockScale)
        iceBlock1.physicsBody = SKPhysicsBody(rectangleOfSize:iceBlock1.size, center:CGPointMake(iceBlock1.size.width/2,
            iceBlock1.size.height/2))
        iceBlock1.physicsBody.dynamic = true
        iceBlock1.physicsBody.affectedByGravity = false
        iceBlock1.physicsBody.allowsRotation = false
        iceBlock1.physicsBody.categoryBitMask = ICEBLOCK1_CATTEGORY_MASK
        iceBlock1.physicsBody.collisionBitMask = PLAYER_CATTEGORY_MASK | GROUND_CATTEGORY_MASK | WALLBLOCK_CATTEGORY_MASK
        
        self  .addChild(iceBlock1)
        
        iceBlock2 = SKSpriteNode(texture:iceBlockTexture)
        iceBlock2.position = CGPointMake(70,282)
        iceBlock2.anchorPoint = CGPointZero
        iceBlock2.setScale(iceBlockScale)
        iceBlock2.physicsBody = SKPhysicsBody(rectangleOfSize:iceBlock2.size, center:CGPointMake(iceBlock2.size.width/2, iceBlock2.size.height/2))
        iceBlock2.physicsBody.dynamic = true
        iceBlock2.physicsBody.affectedByGravity = false
        iceBlock2.physicsBody.allowsRotation = false
        iceBlock2.physicsBody.categoryBitMask = ICEBLOCK2_CATTEGORY_MASK
        iceBlock2.physicsBody.collisionBitMask = PLAYER_CATTEGORY_MASK | GROUND_CATTEGORY_MASK | WALLBLOCK_CATTEGORY_MASK

        self  .addChild(iceBlock2)
        
        iceBlock3 = SKSpriteNode(texture:iceBlockTexture)
        iceBlock3.position = CGPointMake(130,282)
        iceBlock3.setScale(iceBlockScale)
        iceBlock3.anchorPoint = CGPointZero
        iceBlock3.physicsBody = SKPhysicsBody(rectangleOfSize:iceBlock3.size, center:CGPointMake(iceBlock3.size.width/2, iceBlock3.size.height/2))
        iceBlock3.physicsBody.dynamic = true
        iceBlock3.physicsBody.affectedByGravity = false
        iceBlock3.physicsBody.allowsRotation = false
        iceBlock3.physicsBody.categoryBitMask = ICEBLOCK3_CATTEGORY_MASK
        iceBlock3.physicsBody.collisionBitMask = PLAYER_CATTEGORY_MASK | GROUND_CATTEGORY_MASK | WALLBLOCK_CATTEGORY_MASK

        self  .addChild(iceBlock3)
        
        
        iceBlock4 = SKSpriteNode(texture:iceBlockTexture)
        iceBlock4.position = CGPointMake(190,282)
        iceBlock4.setScale(iceBlockScale)
        iceBlock4.anchorPoint = CGPointZero
        iceBlock4.physicsBody = SKPhysicsBody(rectangleOfSize:iceBlock4.size, center:CGPointMake(iceBlock4.size.width/2, iceBlock4.size.height/2))
        iceBlock4.physicsBody.dynamic = true
        iceBlock4.physicsBody.affectedByGravity = false
        iceBlock4.physicsBody.allowsRotation = false
        iceBlock4.physicsBody.categoryBitMask = ICEBLOCK4_CATTEGORY_MASK
        iceBlock4.physicsBody.collisionBitMask = PLAYER_CATTEGORY_MASK | GROUND_CATTEGORY_MASK | WALLBLOCK_CATTEGORY_MASK

        self  .addChild(iceBlock4)
        
        iceBlock5 = SKSpriteNode(texture:iceBlockTexture)
        iceBlock5.position = CGPointMake(250,282)
        iceBlock5.setScale(iceBlockScale)
        iceBlock5.anchorPoint = CGPointZero
        iceBlock5.physicsBody = SKPhysicsBody(rectangleOfSize:iceBlock5.size, center:CGPointMake(iceBlock5.size.width/2,iceBlock5.size.height/2))
        iceBlock5.physicsBody.dynamic = true
        iceBlock5.physicsBody.affectedByGravity = false
        iceBlock5.physicsBody.allowsRotation = false
        iceBlock5.physicsBody.categoryBitMask = ICEBLOCK5_CATTEGORY_MASK
        iceBlock5.physicsBody.collisionBitMask = PLAYER_CATTEGORY_MASK | GROUND_CATTEGORY_MASK | WALLBLOCK_CATTEGORY_MASK

        self  .addChild(iceBlock5)
        


        playerOrigXScaleRight = player.xScale
        playerOrigXScaleLeft = -player.xScale
        
        
       beforeGameTint = SKSpriteNode(texture: nil, color: UIColor .grayColor(), size: self.frame.size)
        beforeGameTint.anchorPoint = CGPointZero
        beforeGameTint.alpha = 0.6
        
        self .addChild(beforeGameTint)
        
        countDownLabel.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        countDownLabel.fontSize = 100
        
        
        playerOnIce1 = false
        playerOnIce2 = false
        playerOnIce3 = false
        playerOnIce4 = false
        playerOnIce5 = false
        
        
        //Timers

        startTimer = NSTimer .scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
        

        
    }
    
    func countDown(){
        if countDownNum == 3{
            countDownLabel.text = "\(countDownNum)"

            self .addChild(countDownLabel)

        }
        if countDownNum > 0{
            
            countDownLabel.text = "\(countDownNum)"

            countDownNum = countDownNum - 1
            
        }
        else {
            startTimer .invalidate()
            
            gameStart = true
            
            countDownLabel .removeFromParent()
            beforeGameTint .removeFromParent()
            canDropMonsters = true
            shouldDropCoin = true
            

        if monDropTimer{

            
        }else{

            
            monDropTimer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector:"dropIce", userInfo: nil, repeats: true)?
            
        }
        
        
        if coinDropTimer{
            println("HI")
            
        }else{
            println("bye")
            coinDropTimer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector:"dropCoin", userInfo: nil, repeats: true)?
            
        }
        }
        
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self.scene)
        if gameStart == true {
       
                
            if location.x > player.position.x{


                player.xScale = playerOrigXScaleRight

            player.physicsBody.velocity = CGVectorMake(playerXVelocity, player.physicsBody.velocity.dy)
            }

            else {
            player.physicsBody.velocity = CGVectorMake(playerXVelocity * -1, player.physicsBody.velocity.dy)

                player.xScale = playerOrigXScaleLeft

            }
            }
            if CGRectContainsPoint(retryButton.frame, location){
                restartScene()
            }else if CGRectContainsPoint(menuButton.frame, location){
                
                var scene:menuScene!
                
                scene = menuScene(size: self.view.bounds.size)
                scene.scaleMode = .AspectFill
                
                // Present the scene.
                
                
                self.view.presentScene(scene)
                
                
                for node:AnyObject in self.children{
                    
                    node .removeFromParent()
                    
                    
                }

                

                
            }

        }

        
    
    }
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        
        if gameStart == true{
        if player.physicsBody.velocity.dx > 0{
            
            player.physicsBody.velocity = CGVectorMake(80, player.physicsBody.velocity.dy)
            
        }else{
            
            player.physicsBody.velocity = CGVectorMake(-80, player.physicsBody.velocity.dy)
            
        }
        }
        
        
    }
    override func update(currentTime: CFTimeInterval) {
        
        scoreLabel.text = "Score: \(score)"
        
        /* Called before each frame is rendered */

        //Collision
        
        if gameStart == true {
        
        if CGRectIntersectsRect(player.frame,CGRectMake(iceBlock1.position.x, iceBlock1.position.y + iceBlock1.frame.height/2, iceBlock1.frame.width, iceBlock1.frame.height)
            ){
                player.texture = birdTexture


                iceBlock2CollisionNumber = 0
                iceBlock3CollisionNumber = 0
                iceBlock4CollisionNumber = 0
                iceBlock5CollisionNumber = 0
                
                iceBlock2.texture = iceBlockTexture
                iceBlock3.texture = iceBlockTexture
                iceBlock4.texture = iceBlockTexture
                iceBlock5.texture = iceBlockTexture
                
                iceBlock1CollisionNumber += 1
                
                if iceBlock1CollisionNumber > 30 && iceBlock1CollisionNumber < 60{
                    
                    
     
                    iceBlock1.texture = iceCrackOne0Texture
                    
                    
                    
                }else if iceBlock1CollisionNumber > 60 && iceBlock1CollisionNumber < 90{
                
     
                        iceBlock1.texture = iceCrackTwo1Texture
                    
                }else if iceBlock1CollisionNumber > 90 {
                    
                    iceBlock1.hidden = true
                    iceBlock1.physicsBody.categoryBitMask = BROKEICE_CATTEGORY_MASK
                    
                    if iceBlock1CollisionNumber < 92 {
                        
                        breakIceBlock(iceBlock1)
                        
                    }
                    
                }
                else if iceBlock1CollisionNumber < 30{
                    
                    iceBlock1.texture = iceBlockTexture
                    
                }

                
        }
        else if CGRectIntersectsRect(player.frame,CGRectMake(iceBlock2.position.x, iceBlock2.position.y + iceBlock2.frame.height/2, iceBlock2.frame.width, iceBlock2.frame.height)
            ){
                player.texture = birdTexture

                iceBlock1CollisionNumber = 0
                iceBlock3CollisionNumber = 0
                iceBlock4CollisionNumber = 0
                iceBlock5CollisionNumber = 0
                
                iceBlock1.texture = iceBlockTexture
                iceBlock3.texture = iceBlockTexture
                iceBlock4.texture = iceBlockTexture
                iceBlock5.texture = iceBlockTexture
                
                
                
                iceBlock2CollisionNumber += 1
                
                if iceBlock2CollisionNumber > 30 && iceBlock2CollisionNumber < 60{
                    
                    

                        iceBlock2.texture = iceCrackOne2Texture
                    

                    
                }else if iceBlock2CollisionNumber > 60 && iceBlock2CollisionNumber < 90{
                    
                        iceBlock2.texture = iceCrackTwo2Texture
                    
                    
                }
                else if iceBlock2CollisionNumber > 90 {
            
                    iceBlock2.hidden = true
                    iceBlock2.physicsBody.categoryBitMask = BROKEICE_CATTEGORY_MASK
                    
                    if iceBlock2CollisionNumber < 92 {
                        
                        breakIceBlock(iceBlock2)
                        
                    }
            
                }else if iceBlock2CollisionNumber < 30{
                    
                    iceBlock2.texture = iceBlockTexture
                    
                }

                
        }
        else if CGRectIntersectsRect(player.frame,CGRectMake(iceBlock3.position.x, iceBlock3.position.y + iceBlock3.frame.height/2, iceBlock3.frame.width, iceBlock3.frame.height)
            ){
                player.texture = birdTexture


                iceBlock2CollisionNumber = 0
                iceBlock1CollisionNumber = 0
                iceBlock4CollisionNumber = 0
                iceBlock5CollisionNumber = 0
                
                iceBlock2.texture = iceBlockTexture
                iceBlock1.texture = iceBlockTexture
                iceBlock4.texture = iceBlockTexture
                iceBlock5.texture = iceBlockTexture
                
          
                
                iceBlock3CollisionNumber += 1
                
                if iceBlock3CollisionNumber > 30 && iceBlock3CollisionNumber < 60{
                    
                    
                    iceBlock3.texture = iceCrackOne2Texture
                    
                    
                }else if iceBlock3CollisionNumber > 60 && iceBlock3CollisionNumber < 90{
                    

                    iceBlock3.texture = iceCrackTwo1Texture
              
                    
                }else if iceBlock3CollisionNumber > 90{
                    iceBlock3.hidden = true
                    iceBlock3.physicsBody.categoryBitMask = BROKEICE_CATTEGORY_MASK

                    if iceBlock3CollisionNumber < 92 {
                        
                        breakIceBlock(iceBlock3)
                        
                    }
                }
                else if iceBlock3CollisionNumber < 30{
                    
                    iceBlock3.texture = iceBlockTexture
                    
                }


                
                
                
        }
        else if CGRectIntersectsRect(player.frame,CGRectMake(iceBlock4.position.x, iceBlock4.position.y + iceBlock4.frame.height/2, iceBlock4.frame.width, iceBlock4.frame.height)
            ){

                player.texture = birdTexture


                iceBlock2CollisionNumber = 0
                iceBlock3CollisionNumber = 0
                iceBlock1CollisionNumber = 0
                iceBlock5CollisionNumber = 0
                
                iceBlock2.texture = iceBlockTexture
                iceBlock3.texture = iceBlockTexture
                iceBlock1.texture = iceBlockTexture
                iceBlock5.texture = iceBlockTexture

                
                iceBlock4CollisionNumber += 1
                
                if iceBlock4CollisionNumber > 30 && iceBlock4CollisionNumber < 60{
                    
                    
     
                        iceBlock4.texture = iceCrackOne0Texture
   
                    
                    
                }else if iceBlock4CollisionNumber > 60 && iceBlock4CollisionNumber < 90{
                    

                        iceBlock4.texture = iceCrackTwo0Texture
    
                    
                }else if iceBlock4CollisionNumber > 90{
                    iceBlock4.hidden = true
                    iceBlock4.physicsBody.categoryBitMask = BROKEICE_CATTEGORY_MASK
                    if iceBlock4CollisionNumber < 92 {
                        
                        breakIceBlock(iceBlock4)
                        
                    }

                }
                else if iceBlock4CollisionNumber < 30{
                    
                    iceBlock4.texture = iceBlockTexture
                    
                }

                
                
                
                
        }
        else if CGRectIntersectsRect(player.frame,CGRectMake(iceBlock5.position.x, iceBlock5.position.y + iceBlock5.frame.height/2, iceBlock5.frame.width, iceBlock5.frame.height)
            ){


                player.texture = birdTexture

                

                iceBlock2CollisionNumber = 0
                iceBlock3CollisionNumber = 0
                iceBlock4CollisionNumber = 0
                iceBlock1CollisionNumber = 0
                
                iceBlock2.texture = iceBlockTexture
                iceBlock3.texture = iceBlockTexture
                iceBlock4.texture = iceBlockTexture
                iceBlock1.texture = iceBlockTexture
                
                iceBlock5CollisionNumber += 1
                
                if iceBlock5CollisionNumber > 30 && iceBlock5CollisionNumber < 60{
                    
                    
                        iceBlock5.texture = iceCrackOne1Texture
     
                    
                    
                }else if iceBlock5CollisionNumber > 60 && iceBlock5CollisionNumber < 90{
                    

                        iceBlock5.texture = iceCrackTwo2Texture
                    
                    
                }else if iceBlock5CollisionNumber > 90{
                    iceBlock5.hidden = true
                    iceBlock5.physicsBody.categoryBitMask = BROKEICE_CATTEGORY_MASK
                    
                    if iceBlock5CollisionNumber < 92 {
                        
                    breakIceBlock(iceBlock5)
                    
                    }

                }
                else if iceBlock5CollisionNumber < 30{
                    
                    iceBlock5.texture = iceBlockTexture
                    
                }


                
                
                
        }else{

            iceBlock1CollisionNumber = 0
            iceBlock2CollisionNumber = 0
            iceBlock3CollisionNumber = 0
            iceBlock4CollisionNumber = 0
            iceBlock5CollisionNumber = 0
            
            iceBlock1.texture = iceBlockTexture
            iceBlock2.texture = iceBlockTexture
            iceBlock3.texture = iceBlockTexture
            iceBlock4.texture = iceBlockTexture
            iceBlock5.texture = iceBlockTexture
            
            player.texture = flyBirdTexture

            
            
        }
        
        
        iceBlock1.position.x = 10
        iceBlock2.position.x = 70
        iceBlock3.position.x = 130
        iceBlock4.position.x = 190
        iceBlock5.position.x = 250
        
    }
    }
    func dropCoin(){
        
        if gameStart == true{
        
        var x = arc4random() % 6

        if x == 1 && iceBlock1.hidden == false && shouldDropCoin == true && playerOnIce1 == false{
            
            println("all true")


            coin = SKSpriteNode(imageNamed:"Coin")
            coin.position = CGPointMake(iceBlock1.position.x + iceBlock1.frame.width/2,iceBlock1.position.y + iceBlock1.frame.height)
            coin.setScale(0.4)
            coin.physicsBody = SKPhysicsBody(circleOfRadius:coin.frame.height/2)
            coin.physicsBody.dynamic = true
            coin.physicsBody.density = 0.000009
            coin.physicsBody.allowsRotation = false
            coin.physicsBody.categoryBitMask = COIN_CATTEGORY_MASK
            self.scene .addChild(coin)
            shouldDropCoin = false

        }else if x == 2 && iceBlock2.hidden == false && shouldDropCoin == true && playerOnIce2 == false{

            println("all true")

            coin = SKSpriteNode(imageNamed:"Coin")
            coin.position = CGPointMake(iceBlock2.position.x + iceBlock2.frame.width/2,iceBlock2.position.y + iceBlock2.frame.height)
            coin.setScale(0.4)
            coin.physicsBody = SKPhysicsBody(circleOfRadius:coin.frame.height/2)
            coin.physicsBody.dynamic = true
            coin.physicsBody.density = 0.000009
            coin.physicsBody.allowsRotation = false
            coin.physicsBody.categoryBitMask = COIN_CATTEGORY_MASK
            self.scene .addChild(coin)
            shouldDropCoin = false


            
            
        }else if x == 3 && iceBlock3.hidden == false && shouldDropCoin == true && playerOnIce3 == false{
            println("all true")

            coin = SKSpriteNode(imageNamed:"Coin")

            coin.position = CGPointMake(iceBlock3.position.x + iceBlock3.frame.width/2,iceBlock3.position.y + iceBlock3.frame.height)
            coin.setScale(0.4)
            coin.physicsBody = SKPhysicsBody(circleOfRadius:coin.frame.height/2)
            coin.physicsBody.dynamic = true
            coin.physicsBody.density = 0.000009
            coin.physicsBody.allowsRotation = false
            coin.physicsBody.categoryBitMask = COIN_CATTEGORY_MASK
            self.scene .addChild(coin)
            shouldDropCoin = false


            
            
        }else if x == 4 && iceBlock4.hidden == false && shouldDropCoin == true && playerOnIce4 == false{
            println("all true")

            coin = SKSpriteNode(imageNamed:"Coin")

            coin.position = CGPointMake(iceBlock4.position.x + iceBlock4.frame.width/2,iceBlock4.position.y + iceBlock4.frame.height)
            coin.setScale(0.4)
            coin.physicsBody = SKPhysicsBody(circleOfRadius:coin.frame.height/2)
            coin.physicsBody.dynamic = true
            coin.physicsBody.density = 0.000009
            coin.physicsBody.allowsRotation = false
            coin.physicsBody.categoryBitMask = COIN_CATTEGORY_MASK
            self.scene .addChild(coin)
            shouldDropCoin = false


            
            
        }else if x == 5 && iceBlock5.hidden == false && shouldDropCoin == true && playerOnIce5 == false{
            println("all true")

            coin = SKSpriteNode(imageNamed:"Coin")
            coin.position = CGPointMake(iceBlock5.position.x + iceBlock5.frame.width/2,iceBlock5.position.y + iceBlock5.frame.height)
            coin.setScale(0.4)
            coin.physicsBody = SKPhysicsBody(circleOfRadius:coin.frame.height/2)
            coin.physicsBody.dynamic = true
            coin.physicsBody.density = 0.000009
            coin.physicsBody.allowsRotation = false
            coin.physicsBody.categoryBitMask = COIN_CATTEGORY_MASK
            self.scene .addChild(coin)
            shouldDropCoin = false


            
        }


        }


        
    }
    func dropIce(){
        if gameStart == true {
        if canDropMonsters == true{
        let x = arc4random() % 6
        if x == 1 {
            iceBlock1.physicsBody.velocity = CGVectorMake(iceBlock1.physicsBody.velocity.dx, -700)
            
        }else if x == 2 && iceBlock2.alpha > 0{
            iceBlock2.physicsBody.velocity = CGVectorMake(iceBlock2.physicsBody.velocity.dx, -700)
            
            
            
        }else if x == 3 && iceBlock3.alpha > 0{
            iceBlock3.physicsBody.velocity = CGVectorMake(iceBlock3.physicsBody.velocity.dx, -700)
            
            
        }else if x == 4 && iceBlock4.alpha > 0{
            iceBlock4.physicsBody.velocity = CGVectorMake(iceBlock4.physicsBody.velocity.dx, -700)
            
            
            
        }else if x == 5 && iceBlock5.alpha > 0{
            iceBlock5.physicsBody.velocity = CGVectorMake(iceBlock5.physicsBody.velocity.dx, -700)
            
            
            
            }
            
            }        }
    }
    func gameEnd(){
        //GAME OVER
    
        gameStart = false
        self .addChild(beforeGameTint)
        retryButton .setScale(1.5)
        retryButton.position = CGPointMake(self.frame.width/3, self.frame.height/2)
        self .addChild(retryButton)
        
        menuButton.position = CGPointMake(self.frame.width/2 + menuButton.frame.width/2, self.frame.height/2)
        menuButton .setScale(1.5)
        self .addChild(menuButton)
        
        coinDropTimer = nil
        

        
    }
    func restartScene(){
        
        
        didMoveToView(self.view)
        
        
    }
    
    func didBeginContact(contact: SKPhysicsContact!){
        if gameStart == true {

        let firstNode = contact.bodyA.node
        let secondNode = contact.bodyB.node
        
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == ICEBLOCK1_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == ICEBLOCK1_CATTEGORY_MASK){
            
        
            
            //IceBlock 1 and Player
            playerOnIce1 = true

        
        
        }
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == ICEBLOCK2_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == ICEBLOCK2_CATTEGORY_MASK){
            
            
            
            //IceBlock 2 and Player
            playerOnIce2 = true
            

            
            
        }
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == ICEBLOCK3_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == ICEBLOCK3_CATTEGORY_MASK){
            
            
            
            //Iceblock 3 and Player
            playerOnIce3 = true
            
        }
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == ICEBLOCK4_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == ICEBLOCK4_CATTEGORY_MASK){
            
            
            
            //IceBlock 4 and Player

            playerOnIce4 = true
            
            
        }
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == ICEBLOCK5_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == ICEBLOCK5_CATTEGORY_MASK){
            
            
            
            //IceBlock 5 and Player
            playerOnIce5 = true
            
        }
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == GROUND_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == GROUND_CATTEGORY_MASK){
            
            
            
            //Ground and Player
            gameEnd()

            
        }
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == COIN_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == COIN_CATTEGORY_MASK){
            
            
            
            //Coin and Player
            score += 5
            coin .removeFromParent()
            shouldDropCoin = true
            
            
        }
        
     
    }
    
    func didEndContact(contact: SKPhysicsContact!){
        
        let firstNode = contact.bodyA.node
        let secondNode = contact.bodyB.node
        
        
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == ICEBLOCK1_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == ICEBLOCK1_CATTEGORY_MASK){
            
            
            
            //IceBlock 1 and Player
            
            playerOnIce1 = false
            
            
        }
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == ICEBLOCK2_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == ICEBLOCK2_CATTEGORY_MASK){
            
            
            
            //IceBlock 2 and Player
            playerOnIce2 = false

            
        }
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == ICEBLOCK3_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == ICEBLOCK3_CATTEGORY_MASK){
            
            
            
            //Iceblock 3 and Player

            playerOnIce3 = false
            
        }
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == ICEBLOCK4_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == ICEBLOCK4_CATTEGORY_MASK){
            
            
            
            //IceBlock 4 and Player

            playerOnIce4 = false
            
            
        }
        if ((firstNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == PLAYER_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == ICEBLOCK5_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == ICEBLOCK5_CATTEGORY_MASK){
            
            
            //IceBlock 5 and Player
 
            playerOnIce5 = false
            
        }
        }
    }
    
    func breakIceBlock(block: SKSpriteNode){
    
    
        var peiceOne = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceOne.position = CGPointMake(block.position.x, block.position.y)
        peiceOne.physicsBody = SKPhysicsBody(circleOfRadius: peiceOne.frame.width/2)
        peiceOne .setScale(0.3)
        peiceOne.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceOne.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK
        
        self .addChild(peiceOne)
        
        var peiceTwo = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceTwo.position = CGPointMake(block.position.x + 10, block.position.y + 5)
        peiceTwo.physicsBody = SKPhysicsBody(circleOfRadius: peiceTwo.frame.width/2)
        peiceTwo .setScale(0.3)
        peiceTwo.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceTwo.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK

        self .addChild(peiceTwo)
        
        var peiceThree = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceThree.position = CGPointMake(block.position.x + 20, block.position.y + 20)
        peiceThree.physicsBody = SKPhysicsBody(circleOfRadius: peiceThree.frame.width/2)
        peiceThree .setScale(0.3)
        peiceThree.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceThree.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK

        self .addChild(peiceThree)
        
        var peiceFour = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceFour.position = CGPointMake(block.position.x + 30, block.position.y + 10)
        peiceFour.physicsBody = SKPhysicsBody(circleOfRadius: peiceFour.frame.width/2)
        peiceFour .setScale(0.3)
        peiceFour.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceFour.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK

        self .addChild(peiceFour)
        
        var peiceFive = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceFive.position = CGPointMake(block.position.x + 40, block.position.y + 30)
        peiceFive.physicsBody = SKPhysicsBody(circleOfRadius: peiceFive.frame.width/2)
        peiceFive .setScale(0.3)
        peiceFive.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceFive.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK

        self .addChild(peiceFive)
        
        var peiceSix = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceSix.position = CGPointMake(block.position.x + 50, block.position.y + 40)
        peiceSix.physicsBody = SKPhysicsBody(circleOfRadius: peiceSix.frame.width/2)
        peiceSix .setScale(0.3)
        peiceSix.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceSix.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK

        self .addChild(peiceSix)
        

        
    
    }

    
    
    
    

}


