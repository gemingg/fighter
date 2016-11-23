//
//  GameViewController.swift
//  fighter
//
//  Created by 葛明 on 15/12/7.
//  Copyright (c) 2015年 葛明. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

//游戏主界面类
class GameViewController: UIViewController {
    //播放声音对象
    var musicPlayer = AVAudioPlayer()
    
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let menuScene = MenuScene()
        let skView = self.view as! SKView
        
        //这会禁用一个渲染上的优化，但这同时保证了sprite会被按照它们被添加进来的顺序被绘制
        skView.ignoresSiblingOrder = false
        
        menuScene.size = view.bounds.size
        //设置当前场景为菜单场景
        skView.presentScene(menuScene)
        
        //获得背景音乐资源对象
        let musicUrl = Bundle.main.url(forResource: "BackgroundMusic", withExtension: "m4a")
        
        if let url = musicUrl {
            do {
                try musicPlayer = AVAudioPlayer(contentsOf: url)
            }
            catch
            {
                
            }
            
            musicPlayer.numberOfLoops = -1  //无止境的循环
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
        }
        
//        let scene = GameScene()
//        
//        let skView = self.view as! SKView
//        
//        skView.showsFPS = true
//        skView.showsNodeCount = true
//        skView.ignoresSiblingOrder = true
//        
//        scene.scaleMode = .AspectFill
//        
//        scene.size = view.bounds.size
//        
//        skView.presentScene(scene)
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
//        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
//            return .AllButUpsideDown
//        } else {
//            return .All
//        }
        //横屏为-Landscape，竖屏为-Portrait
        //portrait 标准竖屏，upside down 头脚颠倒的竖屏
        //landscape left home键在左边的横屏   landscape right  home键在右边的横屏
        
        return .landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
