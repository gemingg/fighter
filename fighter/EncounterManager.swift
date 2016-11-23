//
//  EncounterManager.swift
//  fighter
//
//  Created by 葛明 on 15/12/20.
//  Copyright © 2015年 葛明. All rights reserved.
//

import SpriteKit
//遭遇场景管理类
class EncounterManager{
    //定义遭遇场景对象数组，都是encountrs文件夹内的sks名字
    let encounterNames: [String] = [
        "EncounterBegin",
        "EncounterBats",
        "EncounterCommon1",
        "EncounterBees",
        "EncounterCommon2",
        "EncounterCoins",
        "EncounterCommon3",
        "EncounterBigGroup",
        "EncounterCommon4",
        "EncounterBigGroup2",
        "EncounterBigGroup3",
        "EncounterBigGroup4",
        "EncounterBigGroup5",
        "EncounterBigGroup6",
        "EncounterBigGroup7"
        
    ]
    //遭遇场景集合(已经将场景中的空node元素转成了真正的游戏元素)
    var encounters: [SKNode] = []
    //当前遭遇场景序号
    var currentEncounterIndex:Int?
    //之前的遭遇场景序号
    var previousEncounterIndex:Int?
    var inOrder:Bool = true  //默认第一次顺序播放所有场景。以后则进入随机模式。
    
    init(){
        
        for encounterFileName in encounterNames{
            let encounter = SKNode()
            
            if let encounterScene = SKScene(fileNamed: encounterFileName){
                
                for placeholder in encounterScene.children{
                    if let node = placeholder as? SKNode{
                        switch node.name!{
                            case "Bat":
                                let bat = Bat()
                                bat.spawn(encounter, position: node.position)
                            
                            case "Bee":
                                let bee = Bee()
                                bee.spawn(encounter, position: node.position)
                            
                            case "Blade":
                                let blade = Blade()
                                blade.spawn(encounter, position: node.position)
                            
                            case "Ghost":
                                let ghost = Ghost()
                                ghost.spawn(encounter, position: node.position)
                            
                            
                            case "MadFly":
                                let madFly = MadFly()
                                madFly.spawn(encounter, position: node.position)
                            
                            
                            case "GoldCoin":
                                let coin = Coin()
                                coin.spawn(encounter, position: node.position)
                                coin.turnToGold()
                            
                            case "BronzeCoin":
                                let coin = Coin()
                                coin.spawn(encounter, position: node.position)

                        default:
                            print("name error:\(node.name)")
                            
                            
                        }
                    }
                }
            }
            
            encounters.append(encounter)
            saveSpritePositions(encounter)
        }
    }
    
    //将场景添加到world中
    func addEncountersToWorld(_ world:SKNode)
    {
        for index in 0 ... encounters.count - 1 {
            encounters[index].position = CGPoint(x: -2000, y: index * 1000)
            world.addChild(encounters[index])
        }
    }
    
    //将元素的坐标值保存下来
    func saveSpritePositions(_ node:SKNode)
    {
        for sprite in node.children{
            if let spriteNode = sprite as? SKSpriteNode{
                let initialPositionValue = NSValue(cgPoint:sprite.position)
                spriteNode.userData = ["initialPosition":initialPositionValue]
                saveSpritePositions(spriteNode)
                
            }
        }
        
    }
    
    //重置场景元素
    func resetSpritePositions(_ node:SKNode)
    {
        for sprite in node.children{
            if let spriteNode = sprite as? SKSpriteNode{
                //元素速度为0
                spriteNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                //元素角速度为0
                spriteNode.physicsBody?.angularVelocity = 0
                //元素角度为0
                spriteNode.zRotation = 0
                
                if let initialPositionVal = spriteNode.userData?.value(forKey: "initialPosition") as? NSValue{
                    spriteNode.position = initialPositionVal.cgPointValue
                }
                
                
                resetSpritePositions(spriteNode)
                
            }
        }
    }
    
    //切换遭遇场景
    func placeNextEncounter(_ currentXPos:CGFloat)
    {
        let encounterCount = UInt32(encounters.count)
        
        if encounterCount < 3
        {
            return
        }
        
        var nextEncounterIndex:Int?
        var trulyNew:Bool?
        
        
        while trulyNew == false || trulyNew == nil {
            //nextEncounterIndex = Int(arc4random_uniform(encounterCount))
            nextEncounterIndex = 0
            if currentEncounterIndex != nil {
                if inOrder == true
                {
                    if currentEncounterIndex!  < encounters.count - 1
                    {
                        nextEncounterIndex = currentEncounterIndex! + 1
                    }
                    else
                    {
                        inOrder = false
                        
                    }
                }
                else
                {
                    nextEncounterIndex = Int(arc4random_uniform(encounterCount))
                }
            }
            
            
            
            
            trulyNew = true
            
            if let currentIndex = currentEncounterIndex{
                if(nextEncounterIndex == currentIndex){
                    trulyNew = false
                }
                
            }
        }
        
        previousEncounterIndex = currentEncounterIndex
        currentEncounterIndex = nextEncounterIndex
        
        let encounter = encounters[currentEncounterIndex!]
        encounter.position = CGPoint(x: currentXPos + 1000, y: 0)
        resetSpritePositions(encounter)
    }
}


