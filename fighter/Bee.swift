//
//  Bee.swift
//  fighter
//
//  Created by 葛明 on 15/12/11.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit
//蜜蜂游戏元素类
class Bee: SKSpriteNode,GameSprite{
    //获取图片集合
    var textureAtlas :SKTextureAtlas = SKTextureAtlas(named: "bee.atlas")
    //定义动画对象
    var flyAnimation = SKAction()
    
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 28, height: 24)) {
        parentNode.addChild(self)
        createAnimations()
        
        self.size = size
        self.position = position
        self.runAction(flyAnimation)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
        
    }
    
    
    func createAnimations()
    {
        let flyFrames:[SKTexture] =
        [textureAtlas.textureNamed("bee.png"),
        textureAtlas.textureNamed("bee_fly.png")]
        
        
        let flyAction = SKAction.animateWithTextures(flyFrames, timePerFrame: 0.14)
        flyAnimation = SKAction.repeatActionForever(flyAction)
    }
    
    
    func onTap() {
        //self.xScale = 4
        //self.yScale = 4
    }
}
