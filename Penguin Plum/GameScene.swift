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

var monDropTimer = NSTimer()
var coinDropTimer = NSTimer()
var startTimer = NSTimer()
var scoreTimer = NSTimer()

var ground =  SKSpriteNode()
var player = SKSpriteNode()
var coin = SKSpriteNode()
var cornerCoin = SKSpriteNode()

var iceBlock1 =  SKSpriteNode()
var iceBlock2 =  SKSpriteNode()
var iceBlock3 =  SKSpriteNode()
var iceBlock4 =  SKSpriteNode()
var iceBlock5 =  SKSpriteNode()

var iceBlock1Sign =  SKSpriteNode()
var iceBlock2Sign =  SKSpriteNode()
var iceBlock3Sign =  SKSpriteNode()
var iceBlock4Sign =  SKSpriteNode()
var iceBlock5Sign =  SKSpriteNode()


var newScoreSprite = SKSpriteNode(imageNamed: "newScore")


var gameStart = false
var gameEndBool = false
var buttonWasPushed = false

var shouldDropCoin = false
var canDropMonsters = false

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




//Brid Textures
var birdNormTexture = SKTexture(imageNamed:"PlayerNOflap")
var flyBirdNormTexture = SKTexture(imageNamed:"PlayerFlap")

var birdTopHatTexture = SKTexture(imageNamed:"playerNOflapTopHat")
var flyBirdTopHatTexture = SKTexture(imageNamed:"playerFlapTopHat")

var birdSnowCapTexture = SKTexture(imageNamed:"playerNOflapSnowCap")
var flyBirdSnowCapTexture = SKTexture(imageNamed:"playerFlapSnowCap")

var birdBunnyEarsTexture = SKTexture(imageNamed:"playerNOflapBunnyEars")
var flyBirdBunnyEarsTexture = SKTexture(imageNamed:"playerFlapBunnyEars")

var birdVikingHatTexture = SKTexture(imageNamed:"playerNOflapVikingHat")
var flyBirdVikingHatTexture = SKTexture(imageNamed:"playerFlapVikingHat")

var playerScale:CGFloat = 1

var playerNoFlyTexture = birdNormTexture
var playerFlyTexture = flyBirdNormTexture
var currentOutfit = userDefaults .integerForKey("currentOutfit")



var iceBlock1CollisionNumber = 0
var iceBlock2CollisionNumber = 0
var iceBlock3CollisionNumber = 0
var iceBlock4CollisionNumber = 0
var iceBlock5CollisionNumber = 0

var score = 0

var countDownNum = 3

var scoreLabel = SKLabelNode(fontNamed:"GillSans-BoldItalic")
var countDownLabel = SKLabelNode(fontNamed:"GillSans-BoldItalic")
var highScoreLabel = SKLabelNode(fontNamed:"AmericanTypewriter-Bold")
var endScoreLabel = SKLabelNode(fontNamed:"AmericanTypewriter-Bold")
var coinLabel = SKLabelNode(fontNamed:"GillSans-BoldItalic")


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

let userDefaults = NSUserDefaults .standardUserDefaults()

var highScore = userDefaults .integerForKey("highScore")
var coinNum = userDefaults .integerForKey("coin")


var newHighScore = false


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMoveToView(view: SKView) {
        self .removeAllChildren()


        highScore = userDefaults .integerForKey("highScore")

        currentOutfit = userDefaults .integerForKey("currentOutfit")
        
        //Determin PLayer skin
        if  currentOutfit == 0 {
            
            playerFlyTexture = flyBirdNormTexture
            playerNoFlyTexture = birdNormTexture
            
            playerScale = 0.5
            
        }else if currentOutfit == 1 {
            
            playerFlyTexture = flyBirdSnowCapTexture
            playerNoFlyTexture = birdSnowCapTexture
            
            playerScale = 1
            
            
         
            

        }else if currentOutfit == 2 {
            
            playerFlyTexture = flyBirdBunnyEarsTexture
            playerNoFlyTexture = birdBunnyEarsTexture
            
            playerScale = 1
            
            
      
            
            
        }else if currentOutfit == 3 {
            
            
            
            
            playerFlyTexture = flyBirdTopHatTexture
            playerNoFlyTexture = birdTopHatTexture
            
            playerScale = 1
            
            
        }else if currentOutfit == 4 {
            
            
            
            playerFlyTexture = flyBirdVikingHatTexture
            playerNoFlyTexture = birdVikingHatTexture
            
            playerScale = 1
            
       
            
            
        }else if currentOutfit == 5 {
            
            
            

            
            
        }else if currentOutfit == 6 {
            
            

           
            
        }
        
        countDownNum = 3
        gameStart = false
        gameEndBool = false

        newHighScore = false
        coinDropTimer .invalidate()
        monDropTimer .invalidate()
        startTimer .invalidate()
        scoreTimer .invalidate()
        
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
        scoreLabel.fontSize = 25;
        scoreLabel.position = CGPointMake(10 + scoreLabel.frame.width/2, self.frame.height - 35)
        self.addChild(scoreLabel)

        

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
        


        
        
        
        //Physics
        self.physicsWorld.gravity = CGVectorMake(0, -7)
        let physicsBody = SKPhysicsBody(edgeLoopFromRect:self.frame)
        self.physicsBody = physicsBody
        self.physicsBody.categoryBitMask = WALLBLOCK_CATTEGORY_MASK
        self.physicsWorld.contactDelegate = self

        
        //Player

        playerNoFlyTexture.filteringMode = SKTextureFilteringMode.Nearest
        player = SKSpriteNode(texture:playerNoFlyTexture)
        player.position = CGPointMake(self.frame.width/2, 285 + player.frame.height)
        player.physicsBody = SKPhysicsBody(circleOfRadius:player.frame.height/2)
        player.physicsBody.dynamic = true
        player.physicsBody.allowsRotation = false
        
        
        player.physicsBody.categoryBitMask = PLAYER_CATTEGORY_MASK
        player.physicsBody.collisionBitMask = ICEBLOCK1_CATTEGORY_MASK | ICEBLOCK2_CATTEGORY_MASK | ICEBLOCK3_CATTEGORY_MASK | ICEBLOCK4_CATTEGORY_MASK | ICEBLOCK5_CATTEGORY_MASK | WALLBLOCK_CATTEGORY_MASK | GROUND_CATTEGORY_MASK
        
        player.physicsBody.contactTestBitMask = ICEBLOCK1_CATTEGORY_MASK | ICEBLOCK2_CATTEGORY_MASK | ICEBLOCK3_CATTEGORY_MASK | ICEBLOCK4_CATTEGORY_MASK | ICEBLOCK5_CATTEGORY_MASK | GROUND_CATTEGORY_MASK | COIN_CATTEGORY_MASK
        
        player.setScale(playerScale)
        
        player.physicsBody.density = 0.0001
        self.scene .addChild(player)
        
        

        //Ground
        var groundTexture = SKTexture(imageNamed:"Ground")
        groundTexture.filteringMode = SKTextureFilteringMode.Nearest
        ground = SKSpriteNode(texture:groundTexture)
        ground.position = CGPointMake(self.frame.width/2, 3)
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
        


        
        iceBlock1Sign = SKSpriteNode(imageNamed: "coinSign")
        iceBlock1Sign.position = CGPointMake(iceBlock1.position.x + iceBlock1.frame.width/2, ground.position.y + ground.frame.height/2 + iceBlock1Sign.frame.height/2)
        iceBlock1Sign .setScale(0.7)
        
        iceBlock2Sign = SKSpriteNode(imageNamed: "coinSign")
        iceBlock2Sign.position = CGPointMake(iceBlock2.position.x + iceBlock2.frame.width/2, ground.position.y + ground.frame.height/2 + iceBlock2Sign.frame.height/2)
        iceBlock2Sign .setScale(0.7)

        
        iceBlock3Sign = SKSpriteNode(imageNamed: "coinSign")
        iceBlock3Sign.position = CGPointMake(iceBlock3.position.x + iceBlock3.frame.width/2, ground.position.y + ground.frame.height/2 + iceBlock3Sign.frame.height/2)
        iceBlock3Sign .setScale(0.7)

        
        iceBlock4Sign = SKSpriteNode(imageNamed: "coinSign")
        iceBlock4Sign.position = CGPointMake(iceBlock4.position.x + iceBlock4.frame.width/2, ground.position.y + ground.frame.height/2 + iceBlock4Sign.frame.height/2)
        iceBlock4Sign .setScale(0.7)

        
        iceBlock5Sign = SKSpriteNode(imageNamed: "coinSign")
        iceBlock5Sign.position = CGPointMake(iceBlock5.position.x + iceBlock5.frame.width/2, ground.position.y + ground.frame.height/2 + iceBlock5Sign.frame.height/2)
        iceBlock5Sign .setScale(0.7)

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
            

            monDropTimer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector:"dropIce", userInfo: nil, repeats: true)
            
            
        
        
        

            coinDropTimer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector:"dropCoin", userInfo: nil, repeats: true)
            
            
        
            scoreTimer = NSTimer .scheduledTimerWithTimeInterval(0.5, target: self, selector: "addScore", userInfo: nil, repeats: true)
            
        }
        
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self.scene)
            
            if gameStart == true || gameEndBool == true{
                
                    if location.x > player.position.x{
                        
                        
                        player.xScale = playerOrigXScaleRight
                        
                        player.physicsBody.velocity = CGVectorMake(playerXVelocity, player.physicsBody.velocity.dy)
                    }
                        
                    else {
                        player.physicsBody.velocity = CGVectorMake(playerXVelocity * -1, player.physicsBody.velocity.dy)
                        
                        player.xScale = playerOrigXScaleLeft
                        
                }

                
    
                
                
            if gameEndBool == true {
                
                if CGRectContainsPoint(retryButton.frame, location)
                {
                    buttonWasPushed = true
                    retryButton .removeFromParent()
                    menuButton .removeFromParent()
                    restartScene()
                }
                    
                else if CGRectContainsPoint(menuButton.frame, location)
                {

                    buttonWasPushed = true

                    var scene:menuScene!

                    scene = menuScene(size: self.view.bounds.size)
                    scene.scaleMode = .AspectFill

                    // Present the scene.


                    self .removeAllChildren()
                    self.view.presentScene(scene)

                }
            }
                
                if iceBlock1.hidden == true{
                    
                    if CGRectContainsPoint(iceBlock1Sign.frame, location){

                        buttonWasPushed = true

                        if coinNum >= 20{

                            coinNum -= 20
                            iceBlock1.position.y = player.position.y - iceBlock1.frame.height/2 - player.frame.height

                            iceBlock1.hidden = false
                            iceBlock1.physicsBody.categoryBitMask = ICEBLOCK1_CATTEGORY_MASK
                            iceBlock1Sign .removeFromParent()


                        }
                    
                    
                    }
                }
                if iceBlock2.hidden == true{
                    if CGRectContainsPoint(iceBlock2Sign.frame, location){
                        buttonWasPushed = true

                        if coinNum >= 20{
                            coinNum -= 20
                            iceBlock2.position.y = player.position.y - iceBlock2.frame.height/2 - player.frame.height

                            iceBlock2.hidden = false
                            iceBlock2.physicsBody.categoryBitMask = ICEBLOCK2_CATTEGORY_MASK
                            iceBlock2Sign .removeFromParent()

                        }
                    }
                    
                }
                if iceBlock3.hidden == true{
                    if CGRectContainsPoint(iceBlock3Sign.frame, location){
                        buttonWasPushed = true

                        if coinNum >= 20{
                            
                            coinNum -= 20
                            iceBlock3.position.y = player.position.y - iceBlock3.frame.height/2 - player.frame.height

                            iceBlock3.hidden = false
                            iceBlock3.physicsBody.categoryBitMask = ICEBLOCK3_CATTEGORY_MASK
                            iceBlock3Sign .removeFromParent()

                        }
                    }
                    
                }
                if iceBlock4.hidden == true{
                    if CGRectContainsPoint(iceBlock4Sign.frame, location){
                        buttonWasPushed = true

                        if coinNum >= 20{
                            coinNum -= 20
                            iceBlock4.position.y = player.position.y - iceBlock4.frame.height/2 - player.frame.height

                            iceBlock4.hidden = false
                            iceBlock4.physicsBody.categoryBitMask = ICEBLOCK4_CATTEGORY_MASK
                            iceBlock4Sign .removeFromParent()

                        }
                    }
                    
                }
                if iceBlock5.hidden == true{
                    if CGRectContainsPoint(iceBlock5Sign.frame, location){
                        buttonWasPushed = true

                        if coinNum >= 20{
                            coinNum -= 20
                            iceBlock5.position.y = player.position.y - iceBlock5.frame.height/2 - player.frame.height

                            iceBlock5.hidden = false
                            iceBlock5.physicsBody.categoryBitMask = ICEBLOCK5_CATTEGORY_MASK
                            iceBlock5Sign .removeFromParent()
                            
                        }
                    }
                    
                }
                
            }
        }

        
    
    }
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        /* Called when a touch ends */
        
    

        if buttonWasPushed == true {
            
            player.physicsBody.velocity = CGVectorMake(0, player.physicsBody.velocity.dy)

            buttonWasPushed = false

        }else{
  
        if gameStart == true || gameEndBool == true{
            
            
            
            
            
            if player.physicsBody.velocity.dx > 0{
                
                
                
                player.physicsBody.velocity = CGVectorMake(80, player.physicsBody.velocity.dy)
                
                
                
            }
            else
            {
                
                
                
                player.physicsBody.velocity = CGVectorMake(-80, player.physicsBody.velocity.dy)
                
                
                
            }
            
            
            
            
            
        }
        
        }
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        iceBlock1.position.x = 10
        iceBlock2.position.x = 70
        iceBlock3.position.x = 130
        iceBlock4.position.x = 190
        iceBlock5.position.x = 250
        
        iceBlock1.physicsBody.velocity.dx = 0
        iceBlock2.physicsBody.velocity.dx = 0
        iceBlock3.physicsBody.velocity.dx = 0
        iceBlock4.physicsBody.velocity.dx = 0
        iceBlock5.physicsBody.velocity.dx = 0


        scoreLabel.text = "Score: \(score)"
        coinLabel.text = "x \(coinNum)"
        coinLabel.position = CGPointMake(self.frame.width - coinLabel.frame.width/2, self.frame.height - 35)
        cornerCoin.position = CGPointMake(coinLabel.position.x - coinLabel.frame.width/2 - cornerCoin.frame.width/2, self.frame.height - 35 + cornerCoin.frame.height/2)
        /* Called before each frame is rendered */

        //Collision
        
        if gameStart == true {
        
        if CGRectIntersectsRect(player.frame,CGRectMake(iceBlock1.position.x, iceBlock1.position.y + iceBlock1.frame.height/2, iceBlock1.frame.width, iceBlock1.frame.height)
            ){
                player.texture = playerNoFlyTexture


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
                
                player.texture = playerNoFlyTexture

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
                player.texture = playerNoFlyTexture


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

                player.texture = playerNoFlyTexture


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


                player.texture = playerNoFlyTexture

                

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
            
            player.texture = playerFlyTexture
            

            
            
        }
        
        
        
    }
    }
    
    func addScore(){
        
    
        score += 1
    
    
    
    }
    
    
    func dropCoin(){
        
        if gameStart == true{
        
        var x = arc4random() % 6

            
        if x == 1 && iceBlock1.hidden == false && shouldDropCoin == true {
            


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

        }
            if x == 2 && iceBlock2.hidden == false && shouldDropCoin == true {


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


            
            
        }
            if x == 3 && iceBlock3.hidden == false && shouldDropCoin == true {

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


            
            
        }
            if x == 4 && iceBlock4.hidden == false && shouldDropCoin == true {

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


            
            
        }
            if x == 5 && iceBlock5.hidden == false && shouldDropCoin == true {

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
        


                var x = arc4random() % 5
        

                if x == 0 && iceBlock1.hidden == false {

                iceBlock1.physicsBody.velocity = CGVectorMake(iceBlock1.physicsBody.velocity.dx, -700)
                    
        

                }
        
        
                else if x == 1 && iceBlock2.hidden == false{

                iceBlock2.physicsBody.velocity = CGVectorMake(iceBlock2.physicsBody.velocity.dx, -700)



                }
        
        
                else if x == 2 && iceBlock3.hidden == false{

                iceBlock3.physicsBody.velocity = CGVectorMake(iceBlock3.physicsBody.velocity.dx, -700)


                }
        
        
                else if x == 3 && iceBlock4.hidden == false{

                iceBlock4.physicsBody.velocity = CGVectorMake(iceBlock4.physicsBody.velocity.dx, -700)



                }
        
        
                else if x == 4 && iceBlock5.hidden == false{

                iceBlock5.physicsBody.velocity = CGVectorMake(iceBlock5.physicsBody.velocity.dx, -700)

                }
                    else{
                    
                    dropIce()
    
                    }
        
    }
    
    func gameEnd(){
        //GAME OVER

        scoreTimer .invalidate()
        
        gameEndBool = true
        
        player.texture = playerNoFlyTexture

        
        
        userDefaults .setInteger(coinNum, forKey: "coin")
        
        if score > highScore {
            
            userDefaults .setInteger(highScore, forKey: "highScore")

            
            
            highScore = score
            

            endScoreLabel.fontColor = UIColor(red: 25, green: 25, blue: 25, alpha: 1)
            
            newHighScore = true
            
        }else{
            endScoreLabel.fontColor = UIColor .whiteColor()

        }
    
        gameStart = false
        self .addChild(beforeGameTint)
        retryButton .setScale(1.5)
        retryButton.position = CGPointMake(self.frame.width/3, self.frame.height/2)
        self .addChild(retryButton)
        
        menuButton.position = CGPointMake(self.frame.width/2 + menuButton.frame.width, self.frame.height/2)
        menuButton .setScale(1.5)
        self .addChild(menuButton)
        
        coinDropTimer .invalidate()
        monDropTimer .invalidate()
        
        highScoreLabel.position = CGPointMake(self.frame.width/2, self.frame.height/2 - 50)
        highScoreLabel.text = "Best Score: \(highScore)"
        highScoreLabel.fontSize = 25
        highScoreLabel.fontColor = UIColor .cyanColor()
        self .addChild(highScoreLabel)

        endScoreLabel.position = CGPointMake(highScoreLabel.position.x, highScoreLabel.position.y - 30)
        endScoreLabel.text = "Your Score: \(score)"
        endScoreLabel.fontSize = 25
        self .addChild(endScoreLabel)
        
        if newHighScore == true{
            
            newScoreSprite.position = CGPointMake(highScoreLabel.position.x + highScoreLabel.frame.width/2, highScoreLabel.position.y + newScoreSprite.frame.height)
            newScoreSprite .setScale(0.8)
            
            self .addChild(newScoreSprite)

        }
        
        userDefaults .synchronize()

        

        
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
            coinNum += 1
            coin .removeFromParent()
            shouldDropCoin = true
            
            
        }
        if ((firstNode.physicsBody.categoryBitMask == BROKEICEPEICE_CATTEGORY_MASK) || (secondNode.physicsBody.categoryBitMask == BROKEICEPEICE_CATTEGORY_MASK )) && ((firstNode.physicsBody.categoryBitMask == GROUND_CATTEGORY_MASK) || secondNode.physicsBody.categoryBitMask == GROUND_CATTEGORY_MASK){
            
            
            if firstNode.physicsBody.categoryBitMask == BROKEICEPEICE_CATTEGORY_MASK {
                
                firstNode .removeFromParent()
            
            }
            if secondNode.physicsBody.categoryBitMask == BROKEICEPEICE_CATTEGORY_MASK{
                secondNode .removeFromParent()
            }
            
            
        }

        
     
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
    
    
    func breakIceBlock(block: SKSpriteNode){
    
    
        addSign(block)
        
        var peiceOne = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceOne.position = CGPointMake(block.position.x, block.position.y)
        peiceOne.physicsBody = SKPhysicsBody(circleOfRadius: peiceOne.frame.width/2)
        peiceOne .setScale(0.3)
        peiceOne.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceOne.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK
        peiceOne.physicsBody.contactTestBitMask = GROUND_CATTEGORY_MASK
        
        self .addChild(peiceOne)
        
        var peiceTwo = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceTwo.position = CGPointMake(block.position.x + 10, block.position.y + 5)
        peiceTwo.physicsBody = SKPhysicsBody(circleOfRadius: peiceTwo.frame.width/2)
        peiceTwo .setScale(0.3)
        peiceTwo.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceTwo.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK
        peiceTwo.physicsBody.contactTestBitMask = GROUND_CATTEGORY_MASK

        self .addChild(peiceTwo)
        
        var peiceThree = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceThree.position = CGPointMake(block.position.x + 20, block.position.y + 20)
        peiceThree.physicsBody = SKPhysicsBody(circleOfRadius: peiceThree.frame.width/2)
        peiceThree .setScale(0.3)
        peiceThree.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceThree.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK
        peiceThree.physicsBody.contactTestBitMask = GROUND_CATTEGORY_MASK

        self .addChild(peiceThree)
        
        var peiceFour = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceFour.position = CGPointMake(block.position.x + 30, block.position.y + 10)
        peiceFour.physicsBody = SKPhysicsBody(circleOfRadius: peiceFour.frame.width/2)
        peiceFour .setScale(0.3)
        peiceFour.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceFour.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK
        peiceFour.physicsBody.contactTestBitMask = GROUND_CATTEGORY_MASK

        self .addChild(peiceFour)
        
        var peiceFive = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceFive.position = CGPointMake(block.position.x + 40, block.position.y + 30)
        peiceFive.physicsBody = SKPhysicsBody(circleOfRadius: peiceFive.frame.width/2)
        peiceFive .setScale(0.3)
        peiceFive.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceFive.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK
        peiceFive.physicsBody.contactTestBitMask = GROUND_CATTEGORY_MASK

        self .addChild(peiceFive)
        
        var peiceSix = SKSpriteNode(imageNamed:"BrokenIcePeice")
        peiceSix.position = CGPointMake(block.position.x + 50, block.position.y + 40)
        peiceSix.physicsBody = SKPhysicsBody(circleOfRadius: peiceSix.frame.width/2)
        peiceSix .setScale(0.3)
        peiceSix.physicsBody.categoryBitMask = BROKEICEPEICE_CATTEGORY_MASK
        peiceSix.physicsBody.collisionBitMask = GROUND_CATTEGORY_MASK
        peiceSix.physicsBody.contactTestBitMask = GROUND_CATTEGORY_MASK

        self .addChild(peiceSix)
        

        
    
    }
    
    func addSign(block:SKSpriteNode){

        
        
        if block.position.x == 10{
            //block 1
            self .addChild(iceBlock1Sign)

            
        }else if block.position.x == 70{
            //block 2
            self .addChild(iceBlock2Sign)

        }else if block.position.x == 130{
            //block 3
            self .addChild(iceBlock3Sign)

            
        }else if block.position.x == 190{
            //block 4
            self .addChild(iceBlock4Sign)

            
        }else if block.position.x == 250{
            //block 5
            self .addChild(iceBlock5Sign)

            
        }
        
        
        
        
        
        
    }

}