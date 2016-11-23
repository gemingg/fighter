//
//  Bat.swift
//  fighter
//
//  Created by 葛明 on 15/12/19.
//  Copyright © 2015年 葛明. All rights reserved.
//


import SpriteKit
//蝙蝠游戏元素类
class Bat:SKSpriteNode , GameSprite {
    //获取图片集合
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "enemies.atlas")
    //定义动画对象
    var flyAnimation = SKAction()
    
    func spawn(_ parentNode: SKNode, position: CGPoint, size: CGSize = CGSize(width: 44, height: 24)) {
        parentNode.addChild(self)
        createAnimations()
        
        self.size = size
        self.position = position
        self.run(flyAnimation)//执行动画
        //定义物理效果体的范围为 以宽度一半为半径的一个圆（包含了自身，并超出了一点）
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        //不受重力影响（可以漂浮在空中）
        self.physicsBody?.affectedByGravity = false
        //用于碰撞判断，定义对象的碰撞值
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        //用于碰撞判断，定义对象的碰撞掩码值（就是说哪些碰撞值可以跟该对象接触会引发碰撞物理事件）
        //当两个物体相互接触时，该物体的碰撞掩码与另一个物体的类别掩码执行“逻辑与”运算，如果结果为非零值，该物体能够对另一个物体的碰撞发生反应
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPenguin.rawValue
    }
    
    //创建自身动画
    func createAnimations()
    {
        //定义图片数组
        let flyFrames:[SKTexture] = [
            textureAtlas.textureNamed("bat-fly-1.png"),
            textureAtlas.textureNamed("bat-fly-2.png"),
            textureAtlas.textureNamed("bat-fly-3.png"),
            textureAtlas.textureNamed("bat-fly-4.png"),
            textureAtlas.textureNamed("bat-fly-3.png"),
            textureAtlas.textureNamed("bat-fly-2.png")
        ]
        //定义一个每隔0.06秒顺序显示图片数组中的一张图片的动画对象
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.06)
        //将类中的动画对象定义成永久循环播放上面的动画片的动画对象（动画对象可以嵌套）
        flyAnimation = SKAction.repeatForever(flyAction)
    }
    
    func onTap() {
        
    }
    
}
