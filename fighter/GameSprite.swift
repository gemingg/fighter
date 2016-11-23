//
//  GameSprite.swift
//  fighter
//
//  Created by 葛明 on 15/12/11.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit

//游戏元素根协议，所有的游戏元素都要符合该协议
protocol GameSprite {
    //图片对象集合
    var textureAtlas: SKTextureAtlas{get set}
    //生成游戏元素对象 parentNode : 父对象（容器对象）, position: 出现在父对象中的位置, size: 自身的大小尺寸
    func spawn(_ parentNode : SKNode, position: CGPoint, size: CGSize)
    //单击事件
    func onTap()
    
    
    
}
