//
//  MenuScene.swift
//  fighter
//
//  Created by 葛明 on 15/12/28.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit
//游戏菜单类
class MenuScene :SKScene{
    let textureAtlas : SKTextureAtlas = SKTextureAtlas(named: "hud.atlas")
    
    let startButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        //锚点设置在界面中心处,skscene 的锚点默认是 0，0 。 sknode 的锚点默认是 0.5 ，0.5
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        let backgroundImage = SKSpriteNode(imageNamed: "Background-menu")
        backgroundImage.size = CGSize(width: 1024, height: 768)
        self.addChild(backgroundImage)
        
        let logoText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoText.text = "雯雯的企鹅" //雯雯的企鹅
        logoText.position = CGPoint(x: 0, y: 100)
        logoText.fontSize = 60
        self.addChild(logoText)
        
        
        let logoTextBottom = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoTextBottom.text = "飞出南极大冒险" //飞出南极大冒险
        logoTextBottom.position = CGPoint(x: 0, y: 50)
        logoTextBottom.fontSize = 40
        self.addChild(logoTextBottom)
        
        startButton.texture = textureAtlas.textureNamed("button.png")
        startButton.size = CGSize(width: 295, height: 76)
        
        startButton.name = "StartBtn"
        startButton.position = CGPoint(x: 0, y: -20)
        self.addChild(startButton)
        
        let startText = SKLabelNode(fontNamed: "AvenirNext-HeavyItalic")
        startText.text = "开始游戏"//开始游戏
        startText.verticalAlignmentMode = .center
        startText.position = CGPoint(x: 0, y: 2)
        startText.fontSize = 40
        startText.name = "StartBtn"
        startButton.addChild(startText)
        
        
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.7, duration: 0.9),
            SKAction.fadeAlpha(to: 1, duration: 0.9)
            
            ])
        
        startButton.run(SKAction.repeatForever(pulseAction))
        
    }
    
    //在界面上单击
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches )
        {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            //根据单击的位置找出是不是按钮控件，如果是，则更换为游戏场景
            if nodeTouched.name == "StartBtn"  {
                self.view?.presentScene(GameScene(size:self.size))
            }
        }
    }
}
