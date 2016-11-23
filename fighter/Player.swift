//
//  Player.swift
//  fighter
//
//  Created by 葛明 on 15/12/11.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit
//企鹅游戏元素类
class Player: SKSpriteNode,GameSprite{
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "pierre.atlas")
    
    var flyAnimation = SKAction()//飞动画
    var soarAnimation = SKAction()//升空动画
    
    var flapping = false
    
    //飞行最高力度
    let maxFlappingForce:CGFloat = 57000
    
    //飞行最高高度
    let maxHeight:CGFloat = 1000
    
    //生命值
    var health:Int = 4
    
    //不受伤害的
    var invulnerable = false
    
    //是否处在受伤保护状态
    var damaged = false
    
    
    var damageAnimation = SKAction() //受伤动画
    
    var dieAnimation = SKAction() //死动画
    
    //向前速度
    var forwardVelocity:CGFloat = 200
    
    //吃掉星星的声音
    let powerupSound = SKAction.playSoundFileNamed("Powerup.aif", waitForCompletion: false)
    //受伤的声音
    let hurtSound = SKAction.playSoundFileNamed("Hurt.aif", waitForCompletion: false)
    
    
    
    func spawn(parentNode : SKNode, position: CGPoint, size: CGSize = CGSize(width: 64, height: 64))
    {
        parentNode.addChild(self)
        
        createAnimations()
        
        self.size = size
        
        self.position = position
        
        //self.runAction(flyAnimation,withKey: "flapAnimation")
        self.runAction(soarAnimation,withKey: "soarAnimation")
        
        
        let bodyTexture = textureAtlas.textureNamed("pierre-flying-3.png")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: size)
        
        self.physicsBody?.linearDamping = 0.9//线速度减弱度
        
        self.physicsBody?.mass = 30//重量(千克)
        
        self.physicsBody?.allowsRotation = false
        //一个标记，定义了这个物体所属分类
        self.physicsBody?.categoryBitMask = PhysicsCategory.penguin.rawValue
        //一个标记，定义了哪种物体接触到该物体，该物体会收到通知（谁撞我我会收到通知）  用来抛出接触消息的
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemy.rawValue | PhysicsCategory.ground.rawValue | PhysicsCategory.powerup.rawValue | PhysicsCategory.coin.rawValue
        //当两个物体相互接触时,两个物体都会各自拿自己的categoryBitMask与对方的contactTestBitMask进行逻辑与运算。如果结果为非零值，就会调用代理的接触事件函数
        
        //一个标记，定义了哪种物体会碰撞到自己  用来检测碰撞的
        //self.physicsBody?.collisionBitMask = 0
        //当两个物体相互接触时，该物体的碰撞掩码与另一个物体的类别掩码执行“逻辑与”运算，如果结果为非零值，该物体能够对另一个物体的碰撞发生反应。
        //碰撞检测，默认所有物体之间互相可碰撞。接触消息，默认所有物体接触都不产生消息，这样是为了保证效率。当你对某种接触感兴趣时，单独设置contactTestBitMask，监听这类碰撞消息。
        
        let dotEmitter  = SKEmitterNode(fileNamed: "PierrePath.sks")
        dotEmitter?.particleZPosition = -1
        
        self.addChild(dotEmitter!)
        dotEmitter?.targetNode = self.parent
        
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.velocity.dy = 50
        let startGravitySequence = SKAction.sequence([
            SKAction.waitForDuration(0.6),
            SKAction.runBlock{
                self.physicsBody?.affectedByGravity = true
            }
            ])
        
        self.runAction(startGravitySequence)
        
    }
    
    
    func createAnimations()
    {
        let rotateUpAction = SKAction.rotateByAngle(0, duration: 0.475)
        
        rotateUpAction.timingMode = .EaseOut //刚开始快，后来慢慢慢下来
        
        let rotateDownAction = SKAction.rotateToAngle(-1, duration: 0.8)
        rotateDownAction.timingMode = .EaseIn //刚开始慢，后来慢慢快起来
        
        let flyFrames: [SKTexture] = [
            textureAtlas.textureNamed("pierre-flying-1.png"),
            textureAtlas.textureNamed("pierre-flying-2.png"),
            textureAtlas.textureNamed("pierre-flying-3.png"),
            textureAtlas.textureNamed("pierre-flying-4.png"),
            textureAtlas.textureNamed("pierre-flying-3.png"),
            textureAtlas.textureNamed("pierre-flying-2.png")
        ]
        
        let flyAction = SKAction.animateWithTextures(flyFrames, timePerFrame: 0.03)
        
        flyAnimation = SKAction.group([SKAction.repeatActionForever(flyAction),
            rotateUpAction
        ])
        
        
        
        let soarFrames:[SKTexture] = [textureAtlas.textureNamed("pierre-flying-1.png")]
        let soarAction = SKAction.animateWithTextures(soarFrames, timePerFrame: 1)
        
        
        soarAnimation = SKAction.group([SKAction.repeatActionForever(soarAction),rotateDownAction])
        
        let damageStart = SKAction.runBlock{
            self.physicsBody?.categoryBitMask = PhysicsCategory.damagedPenguin.rawValue
            self.physicsBody?.collisionBitMask = ~PhysicsCategory.enemy.rawValue
        }
        
        let slowFade = SKAction.sequence([
            SKAction.fadeAlphaTo(0.3, duration: 0.35),
            SKAction.fadeAlphaTo(0.7, duration: 0.35)
            
            ])
        
        let fastFade = SKAction.sequence([
            SKAction.fadeAlphaTo(0.3, duration: 0.2),
            SKAction.fadeAlphaTo(0.7, duration: 0.2)
            
            ])
        
        let fadeOutAndIn = SKAction.sequence([
            SKAction.repeatAction(slowFade, count: 2),
            SKAction.repeatAction(fastFade, count: 5),
            SKAction.fadeAlphaTo(1, duration: 0.15)
            ])
        
        let damageEnd = SKAction.runBlock{
            self.physicsBody?.categoryBitMask = PhysicsCategory.penguin.rawValue
            self.physicsBody?.collisionBitMask = 0xFFFFFFFF
            self.damaged = false
        }
        
        self.damageAnimation = SKAction.sequence([
            damageStart,
            fadeOutAndIn,
            damageEnd
            
            ])
        
        let startDie  = SKAction.runBlock{
            self.texture = self.textureAtlas.textureNamed("pierre-dead.png")
            
            self.physicsBody?.affectedByGravity = false
            
            self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            self.physicsBody?.collisionBitMask = PhysicsCategory.ground.rawValue
            
        }
        
        let endDie = SKAction.runBlock{
            self.physicsBody?.affectedByGravity = true
        }
        
        self.dieAnimation = SKAction.sequence([
            startDie,
            SKAction.scaleTo(1.3, duration: 0.5),
            SKAction.waitForDuration(0.5),
            SKAction.rotateToAngle(3, duration: 1.5),
            SKAction.waitForDuration(0.5),
            endDie
            ])
    }
    
    func onTap()
    {
        
    }
    
    
    func update()
    {
        if self.flapping {
            var forceToApply = maxFlappingForce
            
            if position.y > 600 {
                let percentageOfMaxHeight = position.y  / maxHeight
                let flappingForceSubtraction = percentageOfMaxHeight * maxFlappingForce
                forceToApply -= flappingForceSubtraction
                
            }
            //飞的越高，动力越小
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: forceToApply))
            
        }
        
        if self.physicsBody?.velocity.dy > 300 {
            self.physicsBody?.velocity.dy = 300
        }
        
        self.physicsBody?.velocity.dx = self.forwardVelocity
    }
    
    
    func startFlapping(){
        
        if self.health <= 0 { return }
        
        self.removeActionForKey("soarAnimation")
        self.runAction(flyAnimation, withKey: "flapAnimation")
        self.flapping = true
    }
    
    
    func stopFlapping(){
        if self.health <= 0 { return }
        
        self.removeActionForKey("flapAnimation")
        self.runAction(soarAnimation, withKey: "soarAnimation")
        self.flapping = false
    }
    
    func die()
    {
        self.alpha = 1
        
        self.removeAllActions()
        
        self.runAction(self.dieAnimation)
        
        self.flapping = false
        
        self.forwardVelocity = 0
        
        if let gameScene = self.parent?.parent as? GameScene{
            gameScene.gameOver()
        }
    }
    
    func takeDamage()
    {
        if self.invulnerable || self.damaged
        {
            return
        }
        
        self.damaged = true
        
        self.health--
        
        if self.health == 0
        {
            die()
        }
        else
        {
            self.runAction(self.damageAnimation)
        }
        
        self.runAction(hurtSound)
    }
    
    func starPower()
    {
        self.removeActionForKey("starPower")
        self.forwardVelocity = 400
        self.invulnerable = true
        
        let starSequence = SKAction.sequence([
            SKAction.scaleTo(1.5, duration: 0.3),
            SKAction.waitForDuration(8),
            SKAction.scaleTo(1, duration: 1),
            SKAction.runBlock{
                self.forwardVelocity = 200
                self.invulnerable = false
            }
            ])
        
        self.runAction(starSequence,withKey: "starPower")
        
        self.runAction(powerupSound)
        
    }
    
    
    
}
