//
//  MadFly.swift
//  fighter
//
//  Created by 葛明 on 15/12/19.
//  Copyright © 2015年 葛明. All rights reserved.
//


import SpriteKit
//苍蝇游戏元素类
class MadFly:SKSpriteNode,GameSprite{
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "enemies.atlas")
    var flyAnimation = SKAction()
    
    func spawn(_ parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 61, height: 29)) {
        parentNode.addChild(self)
        createAnimations()
        
        self.size = size
        self.position = position
        self.run(flyAnimation)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
    }
    
    func createAnimations(){
        let flyFrames:[SKTexture] = [
            textureAtlas.textureNamed("mad-fly-1.png"),
            textureAtlas.textureNamed("mad-fly-2.png")
        ]
        
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.14)
        flyAnimation  = SKAction.repeatForever(flyAction)
    }
    
    func onTap() {
        
    }
}
