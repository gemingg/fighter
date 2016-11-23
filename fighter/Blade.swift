//
//  Blade.swift
//  fighter
//
//  Created by 葛明 on 15/12/19.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit
//齿轮游戏元素类
class Blade : SKSpriteNode, GameSprite {
    var textureAtlas : SKTextureAtlas = SKTextureAtlas(named: "enemies.atlas")
    var spinAnimation = SKAction()
    
    func spawn(_ parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 185, height: 92)) {
        parentNode.addChild(self)
        self.size = size
        
        self.position = position
        //物理效果体范围是基于图片本身的边缘的（不规则的一个图形）
        self.physicsBody = SKPhysicsBody(texture: textureAtlas.textureNamed("blade-1.png"),  size: size)
        self.physicsBody?.affectedByGravity = false
        //不允许移动，固定的
        self.physicsBody?.isDynamic = false
        
        createAnimations()
        self.run(spinAnimation)
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
    }
    
    func createAnimations()
    {
        let spinFrames:[SKTexture] = [
            textureAtlas.textureNamed("blade-1.png"),
            textureAtlas.textureNamed("blade-2.png")
        ]
        
        let spinAction = SKAction.animate(with: spinFrames, timePerFrame: 0.07)
        spinAnimation = SKAction.repeatForever(spinAction)
        
        
    }
    
    
    func onTap() {
        
    }
    
}
