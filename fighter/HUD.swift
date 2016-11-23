//
//  HUD.swift
//  fighter
//
//  Created by 葛明 on 15/12/26.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit
//状态条类
class HUD : SKNode
{
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "hud.atlas")
    var heartNodes: [SKSpriteNode] = [] //心图标集合（一个心代表一条命）
    
    let coinCountText = SKLabelNode(text: "000000")  //分数
    
    
    let restartButton = SKSpriteNode()  //重新开始按键
    let menuButton = SKSpriteNode()  //菜单按键
    
    
    
    func createHubNodes(_ screenSize:CGSize)
    {
        let coinTextureAtlas:SKTextureAtlas = SKTextureAtlas(named: "goods.atlas")
        let coinIcon = SKSpriteNode(texture: coinTextureAtlas.textureNamed("coin-bronze.png"))
        
        let coinYPos = screenSize.height - 23
        coinIcon.size = CGSize(width: 26, height: 26)
        coinIcon.position = CGPoint(x: 23, y: coinYPos)
        
        
        coinCountText.fontName = "AvenirNext-HeavyItalic"
        coinCountText.position = CGPoint(x: 41, y: coinYPos)
        
        
        coinCountText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        coinCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        
        self.addChild(coinCountText)
        self.addChild(coinIcon)
        
        
        for index in 0  ..< 4  {
            let newHeartNode = SKSpriteNode(texture: textureAtlas.textureNamed("heart-full.png"))
            newHeartNode.size = CGSize(width: 46, height: 40)
            
            let xPos = CGFloat(index * 60 + 33)
            let yPos = screenSize.height - 66
            newHeartNode.position = CGPoint(x: xPos, y: yPos)
            
            heartNodes.append(newHeartNode)
            self.addChild(newHeartNode)
        }
        
        
        restartButton.texture = textureAtlas.textureNamed("button-restart.png")
        menuButton.texture = textureAtlas.textureNamed("button-menu.png")
        
        restartButton.name = "restartGame"
        menuButton.name = "returnToMenu"
        
        let centerOfHud = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        restartButton.position = centerOfHud
        menuButton.position = CGPoint(x: centerOfHud.x - 140, y: centerOfHud.y)
        
        restartButton.size = CGSize(width: 140, height: 140)
        menuButton.size = CGSize(width: 70, height: 70)
        
        
    }
    //设置分数
    func setCoinCountDisplay(_ newCoinCount:Int)
    {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 6 //6位数
        if let coinStr = formatter.string(from:newCoinCount as NSNumber)  {
            coinCountText.text = coinStr
        }
    }
    //设置生命心的状态
    func setHealthDisplay(_ newHealth: Int){
        let fadeAction = SKAction.fadeAlpha(to: 0.2, duration: 0.3)
        
        for index in 0 ..< heartNodes.count   {
            if index < newHealth {
                heartNodes[index].alpha = 1
            }
            else
            {
                heartNodes[index].run(fadeAction)
            }
        }
    }
    
    //显示按钮
    func showButtons()
    {
        restartButton.alpha = 0
        menuButton.alpha = 0
        self.addChild(restartButton)
        self.addChild(menuButton)
        
        let fadeAnimation = SKAction.fadeAlpha(to: 1, duration: 0.4)
        restartButton.run(fadeAnimation)
        menuButton.run(fadeAnimation)
    }
}
