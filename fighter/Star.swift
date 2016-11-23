//
//  Star.swift
//  fighter
//
//  Created by 葛明 on 15/12/19.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit
//星星游戏元素类
class Star : SKSpriteNode, GameSprite{
    
    var textureAtlas : SKTextureAtlas = SKTextureAtlas(named: "goods.atlas")
    var pulseAnimation = SKAction()
    
    func spawn(_ parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 40, height: 38)) {
        parentNode.addChild(self)
        
        createAnimations()
        
        self.size = size
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.texture = textureAtlas.textureNamed("power-up-star.png")
        self.run(pulseAnimation)
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.powerup.rawValue
        
    }
    
    
    func createAnimations()
    {
        let pulseOutGroup = SKAction.group([
            SKAction.fadeAlpha(to: 0.85, duration: 0.8),
            SKAction.scale(to: 0.6, duration: 0.8),
            //0.8秒内逆时针旋转-0.3个弧度
            //根据定义，一周的弧度数为2πr/r=2π，360°角=2π弧度，因此，1弧度约为57.3°
            SKAction.rotate(byAngle: -0.3, duration: 0.8)
            ]);
        
        let pulseInGroup = SKAction.group([
            SKAction.fadeAlpha(to: 1, duration: 1.5),
            SKAction.scale(to: 1, duration: 1.5),
            //1.5秒内逆时针旋转3.5个弧度
            SKAction.rotate(byAngle: 3.5, duration: 1.5)
            ]);
        
        let  pulseSequence = SKAction.sequence([
            pulseOutGroup,pulseInGroup
            ])
        
        pulseAnimation = SKAction.repeatForever(pulseSequence)
    }
    
    func onTap() {
        
    }
    
}
