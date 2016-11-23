//
//  Ground.swift
//  fighter
//
//  Created by 葛明 on 15/12/11.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit
//大地游戏元素类
class Ground:SKSpriteNode, GameSprite{
    
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "ground.atlas")
    
    var groundTexture : SKTexture?
    
    var jumpWidth = CGFloat()//起跳宽度
    
    var jumpCount = CGFloat(1)//起跳次数
    
    
    
    func spawn(_ parentNode: SKNode, position: CGPoint, size: CGSize) {
        parentNode.addChild(self)
        self.size = size
        self.position = position
        //锚点为左上角
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        if groundTexture == nil{
            groundTexture = textureAtlas.textureNamed("ice-tile.png")
            
        }
        
        createChildren()
        
        let pointTopRight = CGPoint(x: size.width, y: 0)
        //物理体是顶部的一条线
        self.physicsBody = SKPhysicsBody(edgeFrom: CGPoint.zero, to: pointTopRight)
        
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
        
        
    }
    
    
    func createChildren()
    {
        if let texture = groundTexture{
            
            var tileCount:CGFloat = 0
            
            let textureSize = texture.size()
            
            //用图片真实尺寸的一半，是为了显示效果更清晰
            let tileSize = CGSize(width: textureSize.width / 2, height: textureSize.height / 2)
            
            //平铺满整个大地（3个屏幕宽）
            while tileCount * tileSize.width < self.size.width {
                let tileNode = SKSpriteNode(texture: texture)
                tileNode.size = tileSize
                
                tileNode.position.x = tileCount * tileSize.width
                
                tileNode.anchorPoint = CGPoint(x: 0, y: 1)
                self.addChild(tileNode)
                
                tileCount += 1
            }
            //正好是一个屏幕的宽度
            jumpWidth = tileSize.width * floor(tileCount / 3)
        }
    }
    
    
    func onTap() {
        
    }
    
    func checkForReposition(_ playerProgress:CGFloat){
        let groundJumpPosition = jumpWidth * jumpCount
        //始终保持中间部分在屏幕上
        if playerProgress >= groundJumpPosition{
            self.position.x += jumpWidth
            jumpCount += 1
        }
    }
}


