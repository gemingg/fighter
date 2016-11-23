//
//  Ghost.swift
//  fighter
//
//  Created by 葛明 on 15/12/19.
//  Copyright © 2015年 葛明. All rights reserved.
//
import SpriteKit
//鬼魂游戏元素类
class Ghost:SKSpriteNode,GameSprite{
    
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "enemies.atlas")
    
    var fadeAnimation = SKAction()
    
    func spawn(parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 30, height: 44)) {
        parentNode.addChild(self)
        
        createAnimations()
        
        self.size = size
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2 )
        self.physicsBody?.affectedByGravity = false
        self.texture = textureAtlas.textureNamed("ghost-frown.png")
        self.runAction(fadeAnimation)
        
        self.alpha = 0.8
        
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
    }
    
    func createAnimations()
    {
        let fadeOutGroup = SKAction.group([
            SKAction.fadeAlphaTo(0.3, duration: 2),
            SKAction.scaleTo(0.8, duration: 2)
            ])
        
        
        let fadeInGroup = SKAction.group([
            SKAction.fadeAlphaTo(0.8, duration: 2),
            SKAction.scaleTo(1, duration: 2)
            ])
        
        
        let fadeSequence = SKAction.sequence([
            fadeOutGroup,fadeInGroup
            ])
        
        fadeAnimation = SKAction.repeatActionForever(fadeSequence)
    }
    
    func onTap() {
        
    }
}
