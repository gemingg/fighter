//
//  GameScene.swift
//  fighter
//
//  Created by 葛明 on 15/12/7.
//  Copyright (c) 2015年 葛明. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene , SKPhysicsContactDelegate{
    //世界，所有对象的父对象，容器对象
    let world = SKNode()
    //蜜蜂
    let bee = SKSpriteNode()
    //企鹅，游戏就是控制它的飞行进行的
    let player = Player()
    //大地
    let ground = Ground()
    //运动控制对象
    let motionManager = CMMotionManager()
    //屏幕中心点y坐标
    var screenCenterY = CGFloat()
    //企鹅初始位置坐标
    let initialPlayerPosition =  CGPoint(x: 150, y: 250)
    //企鹅跑到屏幕哪了（x坐标）
    var playerProgress = CGFloat()
    //遭遇场景管理对象
    let encounterManager = EncounterManager()
    //下一个遭遇场景所在位置
    var nextEncounterSpawnPosition = CGFloat(400)
    //星星对象
    let powerUpStar = Star()
    //得分
    var coinsCollected = 0
    //状态条对象
    let hub = HUD()
    //背景集合
    var backgrounds :[Background] = []
    
    
    
    override func didMove(to view: SKView) {
//        let mySprite = SKSpriteNode(color:UIColor.blueColor(), size: CGSize(width: 50, height: 50))
//        
//        mySprite.position = CGPoint(x: 300, y: 300)
//        
//        
//        self.addChild(mySprite)
        
        
        //let demoAction = SKAction.moveTo(CGPoint(x: 100, y: 100), duration: 15)
        
        
        
//        let demoAction = SKAction.scaleTo(4, duration: 5)
//        
//        mySprite.runAction(demoAction)
        
//        let demoAction1 = SKAction.scaleTo(4, duration: 5)
//        
//        let demoAction2 = SKAction.rotateByAngle(3, duration: 5)
        
        //let actionGroup = SKAction.group([demoAction1,demoAction2])
        
//        let actionGroup = SKAction.sequence([demoAction1,demoAction2])
//        
//        mySprite.runAction(actionGroup)
        
        
        
//        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
//        
//        let bee = SKSpriteNode(imageNamed: "bee.png")
//        
//        
//        bee.size = CGSize(width: 28, height: 24)
//        
//        bee.position = CGPoint(x: 250, y: 250)
//        
//        self.addChild(bee)
        
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        
        
        self.addChild(world)
        
        //self.addTheFlyingBee()
        
        
        /*
        
        let bee2 = Bee()
        let bee3 = Bee()
        let bee4 = Bee()
        
        bee2.spawn(world, position: CGPoint(x: 325, y: 325))
        bee3.spawn(world, position: CGPoint(x: 200, y: 325))
        bee4.spawn(world, position: CGPoint(x: 50, y: 200))
        
        let bat = Bat()
        bat.spawn(world, position: CGPoint(x: 400, y: 200))
        
        let blade = Blade()
        blade.spawn(world, position: CGPoint(x: 300, y: 76))
        
        
        let madfly = MadFly()
        madfly.spawn(world, position: CGPoint(x: 50, y: 50))
        
        
        let bronzeCoin = Coin()
        bronzeCoin.spawn(world, position: CGPoint(x: 490, y: 250))
        
        let goldCoin = Coin()
        goldCoin.spawn(world, position: CGPoint(x: 460, y: 250))
        
        let ghost = Ghost()
        ghost.spawn(world, position: CGPoint(x: 50, y: 300))
        
        let star = Star()
        star.spawn(world, position: CGPoint(x: 250, y: 250))
        
        */
        screenCenterY = self.size.height / 2
        
        let groundPosition = CGPoint(x: -self.size.width, y: 30)//大地的位置是在x 屏幕右边  y 30 处
        let groundSize = CGSize(width: self.size.width * 3, height: 0)//大地的大小是在3倍屏幕宽度  高度为0
        
        ground.spawn(world, position: groundPosition, size: groundSize)
        
        player.spawn(world, position: initialPlayerPosition)  //CGPoint(x: 150, y: 250)
        
        //bee2.physicsBody?.mass = 0.2
        //bee2.physicsBody?.applyImpulse(CGVector(dx: -15, dy: 0))
        
        //self.motionManager.startAccelerometerUpdates()
        
        //当前场景中的物理世界是重力加速度为5的物理世界
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        encounterManager.addEncountersToWorld(world)
        
        encounterManager.encounters[0].position = CGPoint(x: 300, y: 0)
        
        powerUpStar.spawn(world, position: CGPoint(x: -2000, y: -2000))
        
        //定义碰触物理事件的代理对象
        self.physicsWorld.contactDelegate = self
        
        hub.createHubNodes(self.size)
        
        self.addChild(hub)
        //将hub 置于所有元素之上
        hub.zPosition = 50
        
        for i in 0...3 {
            backgrounds.append(Background())
            
        }
        
        backgrounds[0].spawn(world, imageName: "Background-1", zPosition: -5, movementMultiplier: 0.75)
        
        backgrounds[1].spawn(world, imageName: "Background-2", zPosition: -10, movementMultiplier: 0.5)
        
        backgrounds[2].spawn(world, imageName: "Background-3", zPosition: -15, movementMultiplier: 0.2)
        
        backgrounds[3].spawn(world, imageName: "Background-4", zPosition: -20, movementMultiplier: 0.1)
        
        self.run(SKAction.playSoundFileNamed("StartGame.aif", waitForCompletion: false))
        
    }
    
    
    func addTheFlyingBee()
    {
        bee.position = CGPoint(x: 250, y: 250)
        bee.size = CGSize(width: 28, height: 24)
        
        world.addChild(bee)
        
        //let bee = SKSpriteNode()
        
        
        //bee.size = CGSize(width: 28, height: 24)
        
        //bee.position = CGPoint(x: 250, y: 250)
        
        //self.addChild(bee)
        
        let beeAtlas = SKTextureAtlas(named: "bee.atlas")
        
        let beeFrames:[SKTexture] = [
            beeAtlas.textureNamed("bee.png"),
            beeAtlas.textureNamed("bee_fly.png")
        ]
        
        
        let flyAction = SKAction.animate(with: beeFrames, timePerFrame: 0.14)
        
        let beeAction = SKAction.repeatForever(flyAction)
        
        
        bee.run(beeAction)
        
        
        let pathLeft = SKAction.moveBy(x: -200, y: -10, duration: 2)
        
        let pathRight = SKAction.moveBy(x: 200, y: 10, duration: 2)
        
        
        let flipTextureNegative = SKAction.scaleX(to: -1, duration: 0)
        let flipTexturePositive = SKAction.scaleX(to: 1, duration: 0)
        
        
        let flightOfTheBee = SKAction.sequence([pathLeft,flipTextureNegative,pathRight,flipTexturePositive])
        
        
        let neverEndingFlight = SKAction.repeatForever(flightOfTheBee)
        
        bee.run(neverEndingFlight)
        
    }
    
    
    override func didSimulatePhysics() {
//        let worldXPos = -(player.position.x * world.xScale - (self.size.width/2))
//        
//        let worldYPos = -(player.position.y * world.yScale - (self.size.height/2))
//        
//        world.position = CGPoint(x: worldXPos, y: worldYPos)
        
        var worldYPos:CGFloat = 0
        
        //飞太高的时候要缩小这个世界
        if(player.position.y > screenCenterY){
            let percentOfMaxHeight = (player.position.y - screenCenterY) / (player.maxHeight - screenCenterY )
            
            let scaleSubtraction = (percentOfMaxHeight > 1 ? 1 : percentOfMaxHeight) * 0.6
            
            let newScale = 1 - scaleSubtraction
            
            world.yScale = newScale
            world.xScale = newScale
            
            worldYPos = -(player.position.y * world.yScale - (self.size.height / 2 ))
            
        }
        
        let worldXPos = -(player.position.x * world.xScale - (self.size.width / 3))
        
        world.position = CGPoint(x: worldXPos, y: worldYPos)
        
        playerProgress = player.position.x - initialPlayerPosition.x
        
        ground.checkForReposition(playerProgress)
        
        
        if player.position.x > nextEncounterSpawnPosition{
            encounterManager.placeNextEncounter(nextEncounterSpawnPosition)
            nextEncounterSpawnPosition += 1100
            
            let starRoll = Int(arc4random_uniform(10))
            if starRoll <= 7 {
                if abs(player.position.x - powerUpStar.position.x) > 1200 {
                    let randomYPos = CGFloat(arc4random_uniform(400))
                    
                    powerUpStar.position = CGPoint(x: nextEncounterSpawnPosition, y: randomYPos)
                    powerUpStar.physicsBody?.angularVelocity = 0
                    powerUpStar.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                }
                
            }
        }
        
        for background in self.backgrounds{
            background.updatePosition(playerProgress)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* Called when a touch begins */
//        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
        
        for touch in (touches ){
            let location = touch.location(in: self)
            
            let nodeTouched = atPoint(location)
            
            if let gameSprite = nodeTouched as? GameSprite {
                gameSprite.onTap()
            }
            
            
            if nodeTouched.name == "restartGame"  {
                self.view?.presentScene(
                GameScene(size: self.size),
                    transition: .crossFade(withDuration: 0.6)
                )
            }
            else if nodeTouched.name == "returnToMenu" {
                self.view?.presentScene(
                    MenuScene(size:self.size),
                transition:.crossFade(withDuration: 0.6)
                )
            }
                
        }
        
        player.startFlapping()
        
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlapping()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlapping()
    }
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        player.update()
        
//        if let accelData = self.motionManager.accelerometerData{
//            var forceAmount : CGFloat
//            var movement = CGVector()
//            
//            switch UIApplication.sharedApplication().statusBarOrientation{
//            case .LandscapeLeft:
//                forceAmount = 20000
//                
//            case .LandscapeRight:
//                forceAmount = -20000
//                
//            default :
//                forceAmount = 0
//            }
//            
//            
//            if accelData.acceleration.y > 0.15 {
//                movement.dx = forceAmount
//            }
//            else if accelData.acceleration.y < -0.15 {
//                movement.dx = -forceAmount
//            }
//            
//            
//            player.physicsBody?.applyForce(movement)
//            
//        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let otherBody : SKPhysicsBody
        
        let penguinMask = PhysicsCategory.penguin.rawValue | PhysicsCategory.damagedPenguin.rawValue
        
        if (contact.bodyA.categoryBitMask & penguinMask) > 0 {
            
            otherBody = contact.bodyB
        }
        else if (contact.bodyB.categoryBitMask & penguinMask) > 0
        {
            otherBody = contact.bodyA
        }
        else
        {
            return
        }
        
        
        switch otherBody.categoryBitMask{
        case PhysicsCategory.ground.rawValue:
            print("hit the ground")
            player.takeDamage()
            hub.setHealthDisplay(player.health)
            
        case PhysicsCategory.enemy.rawValue:
            print("take damage")
            player.takeDamage()
            hub.setHealthDisplay(player.health)
            
        case PhysicsCategory.coin.rawValue:
            print("collect a coin")
            if let coin = otherBody.node as? Coin {
                coin.collect()
                self.coinsCollected += coin.value
                print(self.coinsCollected)
                hub.setCoinCountDisplay(self.coinsCollected)
            }
            
        case PhysicsCategory.powerup.rawValue:
            print("start the power-up")
            player.starPower()
            
        default:
            print("contact with no game logic")
        }
    }
    
    func gameOver()
    {
        hub.showButtons()
    }
    
}

enum PhysicsCategory: UInt32{
    case penguin = 1
    case damagedPenguin = 2
    case ground = 4
    case enemy = 8
    case coin = 16
    case powerup = 32
}
