//
//  Background.swift
//  fighter
//
//  Created by 葛明 on 15/12/26.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit
//背景类
class Background: SKSpriteNode{
    var movementMultiplier  = CGFloat(0) //运动速度倍率
    var jumpAdjustment = CGFloat(0) //切换图的偏移量
    
    let backgroundSize = CGSize(width: 1000, height: 1000)
    
    func spawn(_ parentNode : SKNode , imageName: String, zPosition : CGFloat , movementMultiplier:CGFloat)
    {
        self.anchorPoint = CGPoint.zero
        self.position = CGPoint(x: 0 , y: 30)
        
        self.zPosition = zPosition
        self.movementMultiplier = movementMultiplier
        parentNode.addChild(self)
        
        //产生3个屏幕的背景
        for i in -1...1 {
            let newBGNode = SKSpriteNode(imageNamed: imageName)
            newBGNode.size = backgroundSize
            
            newBGNode.anchorPoint = CGPoint.zero
            
            newBGNode.position = CGPoint(x: i * Int(backgroundSize.width), y: 0)
            self.addChild(newBGNode)
        }
    }
    
    func updatePosition(_ playerProgress:CGFloat)
    {
        let adjustedPosition = jumpAdjustment + playerProgress * (1 - movementMultiplier)
        
        
        if playerProgress - adjustedPosition > backgroundSize.width {
            jumpAdjustment += backgroundSize.width
        }
        
        self.position.x = adjustedPosition
    }
    
}
