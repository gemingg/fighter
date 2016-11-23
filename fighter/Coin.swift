//
//  Coin.swift
//  fighter
//
//  Created by 葛明 on 15/12/19.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit
//金币游戏元素类
class Coin: SKSpriteNode,GameSprite {
    var textureAtlas : SKTextureAtlas = SKTextureAtlas(named: "goods.atlas")
    
    var value = 1
    //定义一个声音播放动作。waitForCompletion：yes 表示动作的持续时间=声音的播放时间。 false 表示动作一播放就完成了
    let coinSound = SKAction.playSoundFileNamed("Coin.aif", waitForCompletion: false)
    
    
    func spawn(_ parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 26, height: 26)) {
        
        parentNode.addChild(self)
        self.size = size
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.texture = textureAtlas.textureNamed("coin-bronze.png")
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
        //表示跟任何游戏元素都不产生碰撞事件
        self.physicsBody?.collisionBitMask = 0
    }
    
    func turnToGold()
    {
        self.texture = textureAtlas.textureNamed("coin-gold.png")
        self.value = 5
    }
    
    func onTap() {
        
    }
    
    //金币收集事件
    func collect()
    {
        self.physicsBody?.categoryBitMask = 0
        
        let collectAnimation = SKAction.group([
            SKAction.fadeAlpha(to: 0, duration: 0.2),//0.2秒之内变成透明的
            SKAction.scale(to: 1.5, duration: 0.2),//0.2秒之内变大至1.5倍
            //以垂直向上的方向移动0.2秒，CGVector表示一个矢量，有x，y 方向
            SKAction.move(by: CGVector(dx: 0, dy: 25), duration: 0.2)
            ])
        
        let resetAfterCollected = SKAction.run{
            self.position.y = 5000
            self.alpha = 1
            self.xScale = 1
            self.yScale = 1
            self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
            
        }
        
        
        let collectSequence = SKAction.sequence([
            collectAnimation,
            resetAfterCollected
            ])
        
        self.run(collectSequence)
        
        self.run(coinSound)
    }
}
